#! /usr/bin/env ruby
## -*- mode: ruby -*-
## = Sample Agent for CrowdWalk
## Author:: Itsuki Noda
## Version:: 0.0 2015/06/28 I.Noda
## Version:: 1.0 2018/10/31 R.Nishida [change calcCost]
##
## === History
## * [2014/06/28]: Create This File.
## * [YYYY/MM/DD]: add more
## == Usage
## * ...

require "date" ;
require 'RubyAgentBase.rb' ;
require 'GateOperation' ;



#--======================================================================
#++
## SampleAgent class
class SampleAgent < RubyAgentBase

  #--============================================================
  #--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  #++
  ## Java から Ruby を呼び出すTriggerでのFilter。
  ## この配列に Java のメソッド名（キーワード）が入っていると、
  ## Ruby 側が呼び出される。入っていないと、無視される。
  ## RubyAgentBase を継承するクラスは、このFilterを持つことが望ましい。
  ## このFilterは、クラスをさかのぼってチェックされる。
  TriggerFilter = [
#                   "preUpdate",
#                   "update",
                    "calcCostFromNodeViaLink",
#                   "calcSpeed",
#                   "calcAccel",
                    "thinkCycle",
                  ] ;

  #--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  #++
  ## call counter
  attr_accessor :counter ;


  #--------------------------------------------------------------
  #++
  ## シミュレーション各サイクルの前半に呼ばれる。
  def initialize(*arg)
    @counter = 0 ;
		@@finish = 0;
    super(*arg) ;
  end

  #--------------------------------------------------------------
  #++
  ## シミュレーション各サイクルの前半に呼ばれる。
  def preUpdate()
#    p ['SampleAgent', :preUpdate, getAgentId(), currentTime()] ;
    @counter += 1;
    return super()
  end

  #--------------------------------------------------------------
  #++
  ## シミュレーション各サイクルの後半に呼ばれる。
  def update()
#    p ['SampleAgent', :update, getAgentId(), currentTime()] ;
    @counter += 1;
    return super() ;
  end

	def getSimulator()
		@counter += 1;
		return super();
	end


  #--------------------------------------------------------------
  #++
  ## あるwayを選択した場合の目的地(_target)までのコスト。
  ## _way_:: 現在進もうとしている道
  ## _node_:: 現在の分岐点
  ## _target_:: 最終目的地
  def calcCostFromNodeViaLink(link, node, target)
		# 通常
		cost = super(link, node, target);
		# 経路選択モデルによるコスト計算
		if getAgentId() then
			# 分岐点
#			if (node.getTags().contains('X_R1-R2')) || (node.getTags().contains('X_R2-R3')) then
      if (node.getTags().contains("X_R1-R2") && (link.getTags().contains("X1_R1") || link.getTags().contains("X1_R2"))) then
				# 他人
        other = 0
				if @@finish < 1 then
		  	  if(link.getTags().contains('X1_R1')) then
            if $atX1toR1_count5[1] > $atX1toR2_count5[1] then
              other = $atX1toR1_count5[1];
              setGoal("EXIT_R1");
              clearRoute();
            end
		    	end
		    	if(link.getTags().contains('X1_R2')) then
            if $atX1toR1_count5[1] < $atX1toR2_count5[1] then
              other = $atX1toR2_count5[1];
              setGoal("EXIT_R2");
              clearRoute();
            end
		    	end
				end

				## コスト
        cost = -1.0 * other
      else
        if (node.getTags().contains("X_R2-R3") && (link.getTags().contains("X2_R2") || link.getTags().contains("X2_R3"))) then
          other = 0
          if @@finish < 1 then
            if(getAlertTable().get(Term_J2closed).nil?) then
              other = $atX2toR3_count5[1];
              setGoal("EXIT_R3");
              clearRoute();
            end
          end
          cost = -1.0 * other
        end

          ## コスト
			end
		end
    return cost
  end

  #--------------------------------------------------------------
  ## message
  Term_J1closed = ItkTerm.ensureTerm("J1_closed");
  Term_J2closed = ItkTerm.ensureTerm("J2_closed");

  #--------------------------------------------------------------
  #++
  ## 速度を計算する。
  ## たまに減速させてみる。
  ## _previousSpeed_:: 前のサイクルの速度。
  ## *return* 速度。
  def calcSpeed(previousSpeed)
#    p ['SampleAgent', :calcSpeed, getAgentId(), currentTime()] ;
    @counter += 1;
    return super(previousSpeed) ;
  end

  #--------------------------------------------------------------
  #++
  ## 加速度を計算する。
  ## _baseSpeed_:: 自由速度。
  ## _previousSpeed_:: 前のサイクルの速度。
  ## *return* 加速度。
  def calcAccel(baseSpeed, previousSpeed)
#    p ['SampleAgent', :calcAccel, getAgentId(), currentTime()] ;
    @counter += 1;
    return super(baseSpeed, previousSpeed) ;
  end

  #--------------------------------------------------------------
  #++
  ## 思考ルーチン。
  ## ThinkAgent のサンプルと同じ動作をさせている。
  def thinkCycle()
#    p ['SampleAgent', :thinkCycle, getAgentId(), currentTime()] ;
    @counter += 1;
  end

end # class SampleAgent
