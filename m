Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A97F1C684
	for <linux-serial@vger.kernel.org>; Fri, 15 Dec 2023 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S5fxRJRT"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF31Wp5007822;
	Fri, 15 Dec 2023 10:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gx09MCQLXn2yYBrOxN691YT/BUXQxqG0nzWUuAZPjMw=; b=S5
	fxRJRTZQ/231TkmpGCxel7p4NymTgBnN7yJEAwAMR6UEOxrB5P5Zv/QuN/44O4KZ
	dV6ja6pce2AO3ClICN5nTOLXXma0Bc4hvwSxSy1dspcyRnSCN/2lS2oEnS5EleNf
	E2RwfOdypbviZpKIv7TvGKq4hehcymKDL82sEcoi6fJ6pnW80gqmdZeuWNC2iblF
	c4qQJgs3HZ55ezpvbxVGbzBKegBknR/fmVIcGSpa89gaIPqx7yWxAorPiGyevfgh
	AwfMsdiWe9FHS7gj8z9ocbtrpn3hWx6g2KhMcINqYV2/dbmU1V0h8h9d0xsJP3pD
	9L/DvbXzkpyHmkfHEltg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v081t1t24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:45:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFAjhnR001755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:45:43 GMT
Received: from [10.253.77.113] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 02:45:42 -0800
Message-ID: <6ccf9dbc-8c81-436a-955c-bf6874dd5203@quicinc.com>
Date: Fri, 15 Dec 2023 18:45:39 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tty: Fix a security issue related to tty-ldisc module
 loading
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>
References: <1702628933-6070-1-git-send-email-quic_zijuhu@quicinc.com>
 <2023121530-crept-unisexual-de76@gregkh>
 <38ca1fa8-5631-4511-8962-31c8948e19b8@quicinc.com>
 <2023121514-likely-sequester-050b@gregkh>
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2023121514-likely-sequester-050b@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ixa4VEmLGSjko7Ahxk0gTV3YLlDBODG_
X-Proofpoint-GUID: ixa4VEmLGSjko7Ahxk0gTV3YLlDBODG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150071

On 12/15/2023 6:38 PM, Greg KH wrote:
> On Fri, Dec 15, 2023 at 05:32:52PM +0800, quic_zijuhu wrote:
>> On 12/15/2023 4:43 PM, Greg KH wrote:
>>> On Fri, Dec 15, 2023 at 04:28:53PM +0800, Zijun Hu wrote:
>>>> Function tty_ldisc_get() has a simple logical error and may cause tty-ldisc
>>>> module to be loaded by a user without CAP_SYS_MODULE, this security issue
>>>> is fixed by correcting the logical error.
>>>
>>> What specific security issue are you referring to here?
>> module tty-ldisc is able to be loaded by a user who don't have relevant permission CAP_SYS_MODULE to load module.
> 
> Yes, that is as-intended, why are you trying to break existing
> functionality that has been present for forever?
> 
i understood current design by looking at historical commit and agree that current design is okay.

>> current logical is weird and it confuse me as a tty driver beginner since the intuitive checking is shown by my change.
> 
> It might be confusing, but it is correct.  You have to justify changing
> existing functionality a lot, especially for user-visable stuff like
> this.
> 
i will add more comments and optimize checking logical but remain current logic in order to make it easy to understand
> And to say it is a "security issue" is not correct, it is this way by
> design, please work to understand history before attempting to change it
> for no documented reason.  Did you read the config option that helps
> control this functionality?  Did the help text there not explain it
> properly?  If so, please provide additional documentation where needed.
> 
make sense.
> I suggest working with others at your company that have more experience
> before submitting changes like this in the future, as they should be
> able to help you out better instead of relying on the community to do
> so.
> 
> thanks,
> 
> greg k-h

