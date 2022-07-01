Trigger OrderObject on Order (before update, after update){
	if(Trigger.isUpdate){
		List<Order> listOrder = trigger.new;
		if(Trigger.isAfter){
			orderTriggerHandler.updateAccountCA(listOrder);
		}
	}
	
}   