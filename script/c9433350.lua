--Sin 青眼の白龍
function c9433350.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c9433350.spcon)
	e1:SetOperation(c9433350.spop)
	c:RegisterEffect(e1)
	--only 1 can exists
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	e2:SetCondition(c9433350.excon)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,1)
	e4:SetCode(EFFECT_CANNOT_SUMMON)
	e4:SetTarget(c9433350.sumlimit)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e6)
	--selfdes
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(c9433350.descon)
	c:RegisterEffect(e7)
	--cannot announce
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e8:SetTargetRange(LOCATION_MZONE,0)
	e8:SetTarget(c9433350.antarget)
	c:RegisterEffect(e8)
end
function c9433350.sumlimit(e,c)
	return c:IsSetCard(0x23)
end
function c9433350.exfilter(c,fid)
	return c:IsFaceup() and c:IsSetCard(0x23) and (fid==nil or c:GetFieldID()<fid)
end
function c9433350.excon(e)
	return Duel.IsExistingMatchingCard(c9433350.exfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c9433350.spfilter(c)
	return c:IsCode(89631139) and c:IsAbleToRemoveAsCost()
end
function c9433350.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c9433350.spfilter,c:GetControler(),LOCATION_DECK,0,1,nil)
		and not Duel.IsExistingMatchingCard(c9433350.exfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c9433350.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=Duel.GetFirstMatchingCard(c9433350.spfilter,tp,LOCATION_DECK,0,nil)
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
end
function c9433350.descon(e)
	local c=e:GetHandler()
	local f1=Duel.GetFieldCard(0,LOCATION_SZONE,5)
	local f2=Duel.GetFieldCard(1,LOCATION_SZONE,5)
	return ((f1==nil or not f1:IsFaceup()) and (f2==nil or not f2:IsFaceup()))
		or Duel.IsExistingMatchingCard(c9433350.exfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,c:GetFieldID())
end
function c9433350.antarget(e,c)
	return c~=e:GetHandler()
end
