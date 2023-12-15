Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC19179B1
	for <linux-serial@vger.kernel.org>; Fri, 15 Dec 2023 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dHAN5rcY"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF6CZuA014241;
	Fri, 15 Dec 2023 09:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XhResauZEweuAEBMBEQ6WZcyzzau/j+35SbDPITUGhg=; b=dH
	AN5rcYB0sBos6opq/W1KfyAGBIE9iMZVKdXc8guxh5On1EruPHVB7E8Wcs1+rWj7
	HgItdggHkogeLSmM8YZbI11fmezBYJroiB2Ds2/4kaFgeRGk8K+GqQ9hgnBC7z7t
	OIVHAD5S4LQOlXCZc5qYCq157W2Ne7KqBJRM5r/0kbkFQsQUk1Nmal11d/Dh5yoL
	Jj8tsK7sqIDB+yZAmg6WyvR0J9ZSBmAtMhXtTTv6cTUQWMv1vTQ+f1L+452cM9wz
	odbazHudrL0V8n5CvnHNOOCbx7YfOzZCVNKQp3U+sVP51GuLCuoee4TaN+0Ez1lB
	4+MKs99hVQ0HPN9kKnEw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hb00kaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 09:32:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF9WuKH027892
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 09:32:56 GMT
Received: from [10.253.77.113] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 01:32:55 -0800
Message-ID: <38ca1fa8-5631-4511-8962-31c8948e19b8@quicinc.com>
Date: Fri, 15 Dec 2023 17:32:52 +0800
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
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2023121530-crept-unisexual-de76@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EKR4muVXbUKPmQjjXPXc91LJwey-X_9v
X-Proofpoint-GUID: EKR4muVXbUKPmQjjXPXc91LJwey-X_9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150063

On 12/15/2023 4:43 PM, Greg KH wrote:
> On Fri, Dec 15, 2023 at 04:28:53PM +0800, Zijun Hu wrote:
>> Function tty_ldisc_get() has a simple logical error and may cause tty-ldisc
>> module to be loaded by a user without CAP_SYS_MODULE, this security issue
>> is fixed by correcting the logical error.
> 
> What specific security issue are you referring to here?
module tty-ldisc is able to be loaded by a user who don't have relevant permission CAP_SYS_MODULE to load module.

current logical is weird and it confuse me as a tty driver beginner since the intuitive checking is shown by my change.

when you want to load a module, check by the following sequences:
1) if you have relevant permission CAP_SYS_MODULE to do it. do NOT do it and return if you don't have permission.
2) then check if we need to do it based on configuration tty_ldisc_autoload, if not configure to do it, do NOT it and return.
3) then do it if PASS previous 2 checks.
> 
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/tty/tty_ldisc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
>> index 3f68e213df1f..b490c0adf00f 100644
>> --- a/drivers/tty/tty_ldisc.c
>> +++ b/drivers/tty/tty_ldisc.c
>> @@ -150,7 +150,7 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
>>  	 */
>>  	ldops = get_ldops(disc);
>>  	if (IS_ERR(ldops)) {
>> -		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
>> +		if (!capable(CAP_SYS_MODULE) || !tty_ldisc_autoload)
> 
> I'm missing something, why change this?
> 
make it follow normal checking logic as mentioned for your 1st question.

> Remember if tty_ldisc_autoload is enabled, then any user can auto-load a
> tty ldisc, permissions are not needed.
> 
it so, it is good to add some comments or optimize checking logic and make it easy to understand.

> as it's confusing to read, let me break this down to see if the original
> code is correct or not:
> 	If you do NOT have CAP_SYS_MODULE AND you do NOT have
> 	tty_ldisc_autoload enabled, then the kernel will NOT call
> 	request_module
> 
> 	If you do have CAP_SYS_MODULE enabled then the kernel will call
> 	request_module()
> 
> 	If you do have tty_ldisc_autoload enabled, then you can autoload
> 	a module.
> 
> Is this not the correct functionality?
> not sure what is the expected functionality when wrote current checking logic.
it seems kernel checks here for a user (perhaps user space process) should load tty-ldisc module.

what are expected actions when wrote current checkings.what is expected actions for below combine conditions?

//user do NOT have permission to load module    autoloaded disabled.          what is expected action? load or unload the module.
CAP_SYS_MODULE = no, 				tty_ldisc_autoload = no,       		?
CAP_SYS_MODULE = no,  				tty_ldisc_autoload = yes, 		? 
CAP_SYS_MODULE = yes, 				 tty_ldisc_autoload = no,     		?
CAP_SYS_MODULE = yes,  				tty_ldisc_autoload = yes,    		? 
> You are changing this to:
> 	If you do NOT have CAP_SYS_MODULE enabled, then no matter what,
> 	do NOT call request_module()
> 
> 	If you do NOT have tty_ldisc_autoload enabled, then no matter
> 	what, do NOT call request_module()
> 
> Are you sure that's what you want to change this to?
> 
yes.
> What am I missing here?
> 
nothing.
> confused,
> 
> greg "boolean logic is hard" k-h

