Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A183033A
	for <linux-serial@vger.kernel.org>; Fri, 15 Dec 2023 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VPUV/eEQ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF6Cv3I002334;
	Fri, 15 Dec 2023 13:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CVl34SAefU/wqawpunawC90x2Cz1N9g2aquP/hZuPnk=; b=VP
	UV/eEQp4qVlZvoAEybxc+WirE0kFuQHXyrDDv22kLM+Tj5v3sEs470QUul0Ri4vC
	KY/AxewIvOnuP3R1fzRZb8GA96e3B1O2dPMQlfgWNKGRyNYe4+57t9pZCtHnZhb2
	/4QgNXaAIop0RkSC5J9ZKy6+UVDYdCMj8XAN1zWLq6ZGszfpHhCAAAo4gSH3HLob
	s/A4PBgoq0NnN/1QFi5mrFqiKf3MZNqEYesIN9P7JOb2Jcgm46/mx1UQBlh3/4yw
	ElfImpNI0XFU+eYR7bl7KR0op4n0bwRIJEqpBYUobjI6AfSwnXFenVZgY9aMj/1k
	J//BaFdTLuHtiZMRKLXA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hb1s1ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 13:24:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFDOq4b007013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 13:24:52 GMT
Received: from [10.253.77.113] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 05:24:51 -0800
Message-ID: <21a8e30d-62ae-47e8-b1d9-bc172053e833@quicinc.com>
Date: Fri, 15 Dec 2023 21:24:48 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tty: Make tty-ldisc module loading logic easy to
 understand
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>
References: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>
 <2023121502-chewer-alto-dba4@gregkh>
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2023121502-chewer-alto-dba4@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qW-RA5gV4o5e350okAsueTErOp-e3zii
X-Proofpoint-ORIG-GUID: qW-RA5gV4o5e350okAsueTErOp-e3zii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=764 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150090

On 12/15/2023 8:17 PM, Greg KH wrote:
> On Fri, Dec 15, 2023 at 07:37:16PM +0800, Zijun Hu wrote:
>> Current tty-ldisc module loading logic within tty_ldisc_get()
>> is prone to mislead beginner that the module is able to be loaded
>> by a user without capability CAP_SYS_MODULE, add comments and
>> optimize the logic to make it easy to undertand.
> 
> You did not "optimize" anything here, you just:
> 
>> -		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
>> +		if (!tty_ldisc_autoload && !capable(CAP_SYS_MODULE))
> 
> Switched the operands around, not really doing anything at all to make
> it "easier" to understand, sorry.
> 
will remove it and only add comments.
> Again, please go work with developers at:
> 
>> The Qualcomm Innovation Center
> 
> To come up with a better change and get them to sign-off on the change
> before resubmitting it to us for review.
> 
i doesn't belong to uart team and i just need to use tty so learn it.
i will also send it to quicinc guys extracted from tty commit history for code review from them.
> thanks,
> 
> greg k-h

