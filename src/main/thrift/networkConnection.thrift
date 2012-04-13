namespace * com.kurento.kms.api

include "common.thrift"
include "joinable.thrift"
include "sessionSpec.thrift"

enum NetworkConnectionConfig {
	RTP,
	RTMP,
}

struct NetworkConnection {
	1: required joinable.Joinable joinable,
	2: required list<NetworkConnectionConfig> config,
}

exception NetworkConnectionNotFoundException {
}

exception NegotiationException {
	1: required string description,
}

service NetworkConnectionService extends joinable.JoinableService {
	sessionSpec.SessionSpec generateOffer(1: NetworkConnection nc) throws (1: NetworkConnectionNotFoundException ncnfe, 2: common.MediaServerException mse),
	sessionSpec.SessionSpec processAnswer(1: NetworkConnection nc, 2: sessionSpec.SessionSpec anwser) throws (1: NetworkConnectionNotFoundException ncnfe, 2: NegotiationException ne, 3: common.MediaServerException mse),
	sessionSpec.SessionSpec processOffer(1: NetworkConnection nc, 2: sessionSpec.SessionSpec offer) throws (1: NetworkConnectionNotFoundException ncnfe, 2: NegotiationException ne, 3: common.MediaServerException mse),

	sessionSpec.SessionSpec getLocalDescriptor(1: NetworkConnection nc) throws (1: NetworkConnectionNotFoundException ncnfe, 2: common.MediaServerException mse),
	sessionSpec.SessionSpec getRemoteDescriptor(1: NetworkConnection nc) throws (1: NetworkConnectionNotFoundException ncnfe, 2: NegotiationException ne, 3: common.MediaServerException mse),
}
