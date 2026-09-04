Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26EA30E0CC
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508987; cv=none; b=cAXQXUl7I3e6YAvPKReBJOTeO2Z0KIWgzhhIkUVIv4YvrnYX4l9i4H9IqBwxi4B5noAEyaGo6c6WWTdLlXods0gjG5X2cUHCO0xVeswciWIWbXOOO3RhIOyQsd3XnpuWPsZTQtlvTcxFmP9Id4G2jsblteJGVypDVUj1n3sZ+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508987; c=relaxed/simple;
	bh=/JxoYyZw8rvXwU7G/U87fprDVpjKUZ0WgJD9uCb5TZk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bnw3oIZ3Ov1cbAZdmHtEPdkU75NV9Rw8XCfQ+o3G9snV7uJDkoGrsMSnky4wVlrKC7wurAOBDgd23MZ0GqozC4+V2Zcl3ZLiUh9C0Eye1MGScVoIvNeA8kVzPBcQpLnkvD6IOgwHUVTWOZ5DNLEUcVNjwgoo1bkZHUyeEbbPzNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QoNwALlq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U/kj58Mi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QoNwALlq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U/kj58Mi"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mjM73234598
	for <linux-serial@vger.kernel.org>; Fri, 4 Sep 2026 08:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eSPnEJt/utJLJrcQDxoCun9VKVut8jjz7U4CayigJTo=; b=QoNwALlqKiwEJowk
	Wz60dx7FmUxaSQvGYxtVxsFkKtHK3FVHGWifqXW8aTQ4XOSCZQHAqI9E16vtbf79
	FQxva20Rj3BPwoA1cbbdSDEKHHlmGVR7Cxd+5ouIK4fWA9tmMbO9K/zCd6OFCCKh
	BEd9z0wGbwX2fqBByT7edi6CapE7KEDZKwRtHRlMYoYxGxg77Rk/bgkcvU5qSy0X
	kB8Rsel0koS3cbYyU/H/X4OZwPwGaTJqnb40qzlqZSpyRLz9VsebjvPHdHO7Q083
	2We48NFHcTV9qG7lqrnCCujks1BdKlL9hn2T8sZ+3FmN/stx3ZB0hlqznabB8Hm8
	2eZt5Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp0r0t4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 08:03:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93495488976so12331385a.3
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788508984; x=1789113784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSPnEJt/utJLJrcQDxoCun9VKVut8jjz7U4CayigJTo=;
        b=U/kj58Mi3iifLfPN1c6AHCY1oL6Q3HejLzY/swzjdpWRgMkHMXIvMEsyCW1Ctm4kZ1
         nqZGKDG8P0oapYfhqicIUYY4fKRq5VSlOAr3US3PJifPs/IiUuBB5aidTnjXbqV2bcCu
         tDjOLkAp0WATHQmCrl90t4Ehv0EwrXezlKSLpmRW21NKU8ipILdpbzmtbTTzq8UlCpa/
         InWTUR9cwv3KOd7jDmrJQ4okDjNt4kr13xKDdloEH69t9EyOVAR/6uG12S7evRQDhMlW
         At1eLzcxnDY/zqzvMcGmDlCg+GjWeI6uDwZqBHj1C+son6RxWQsPaKUW47z4pB8aAQNw
         FLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508984; x=1789113784;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSPnEJt/utJLJrcQDxoCun9VKVut8jjz7U4CayigJTo=;
        b=OYOKZBx7fgYz6OT5q7rK+du90alJipJrDZhXnAoSUH3bgw3JcKA1DnKEeD5nzxj4qd
         akSxKQMALEdwoas1BFn+E8oK3pkt9RoobuWZ9A6w4snFfISq3huJ3v/E7KwhqFG+x+U6
         8za3YJQ+xq4fpBpRwea2b3ZmLgSOjp5d4Z41EL7c5Cyry1VOv5cWE469LYftTVb3GzF3
         z13TGeFAlyqPhiIAcJsf9N9pRnbk9BljEUEypJDou5YXKdtzATd5BpgMh3LKz5OrcYFI
         Uv+Z/ICQOV5PmdZijDZMTOogk+JWRKn3kh1eQBpSlw/ruHiSzvcyTmEFOq08mmRaUPX/
         beOA==
X-Forwarded-Encrypted: i=1; AKwUvBzQ9GBaoNKZLlfpo0zbvNjY5YGy0tKjWi5tb7o7pIt5XuBCy2IHEDVlFEkQrXGOGZMFzhlkfALThtoIO5A=@vger.kernel.org
X-Gm-Message-State: AFuF++l6YLa3UkRMZYNLjg6h4KOGXtZvAHcX7rxGz51AILHQiqLucImO
	HEdKCn81jtQKHTzYeLKmIii6HIVbjRkuKa6UCkcwhTfQ8qekN25hirfjdNmL1gHp/6L8O9eqxrG
	am/0seZA/sL9N58P0bgRIcG+XFG+K8Ud5Agw8mBm1RZc1eaF5pFKo6lGYRjPfuy8reWw=
X-Gm-Gg: AYBFou3WJzUApVil7uWNpx0rnu6C1Tvm453mGSD5xRePefxsn/rZIPBIzXoSKi0bwSD
	vz9stiFjwv5yy5ogN7wFxUStZdiDvxNPz+umt3yRVOkKf2HcX/QmW5L0jFOVht8QLOS7LliEBSn
	NWkGov/SfcQ+OO6nkKcSKYvEtkuHN+uzn46fonMWz6ErDiOJR3XQNGZegLur6NY4+y3Z9vjMd6t
	9royU2hkstNCXrxicJwHgK39z2lkFEiOwpFB/rsPCY7otV/kjJNsQt1ZYE2Ts+UWrhJ+6DquptV
	Z//kVpUQxmMR+yfBwxvji2UjBa3j9okx7le3QywC3xEsZpNscIwTqr/+R2i6xbTzOzpUlsBPdNk
	92e9fX3B3Ke6cO5YCuAJjaA==
X-Received: by 2002:a05:620a:4444:b0:939:6c63:a7da with SMTP id af79cd13be357-93980358fe1mr312045285a.0.1788508983619;
        Fri, 04 Sep 2026 01:03:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4444:b0:939:6c63:a7da with SMTP id af79cd13be357-93980358fe1mr312040985a.0.1788508982948;
        Fri, 04 Sep 2026 01:03:02 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa0c7sm69797766b.20.2026.09.04.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:03:01 -0700 (PDT)
Message-ID: <53b0b91c-6ca6-48a5-b93c-ca2ae9680ad0@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 10:03:00 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: qcom_geni: don't ida_free() the console port
 line
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v1-1-02e18c31aeba@linaro.org>
 <bbd0216d-8b50-424b-be1b-06453118a61b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <bbd0216d-8b50-424b-be1b-06453118a61b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3MyBTYWx0ZWRfXyUtC1sBo4BZp
 tIGHLBPfnMYRTFK2Jtz8Fraf92ykzb9S9zNZ2euqHhhaVjBDxYhv0EMmu+pVn3/kjyC2umFJqMi
 43y6dGTdgh5q/5lqQ5JghkI5C+qJRZk=
X-Proofpoint-ORIG-GUID: M7djVrfoa-TXuZBv2si58Ugpz5CTtAbG
X-Proofpoint-GUID: M7djVrfoa-TXuZBv2si58Ugpz5CTtAbG
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a9a7b38 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=oCYrDJX_Fzh7Vr1zKUEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3MyBTYWx0ZWRfX+i5d36AMgVqy
 FgWSRRCTogGp/997qFwaPJV6nmaA+SSlpkD7wyJC0XJ7MM0a8AVTlhUagcLlE/RiWmADdxaN4pf
 cQtQ4MwFkQRwEHMBA1TsufTgVkTJfK+nDibAmb2PPN8vYHc0oK9h1zUQHHpr9wxiSMTaeBsOMcn
 q+eW1x8y6oMLTAhhtKLp6UaLfgmhGaJO4JM20S6bVTciY2bOkASR/GFy/FGlIF6JZ8A6xBct+iR
 SlFDNGd1spzTP9DOalnVd/nrltO+RBVUQF8VZDkmUFfbKFcAc0YgPtozrqyT34F0nezW0fYvJWk
 lal51m8aC4BV8qLWP/8M4F4PjxjqlJmhu1TrE1Am1nhlOv6N5iqDgK6atLtjar2TmXigIkV5n1+
 THejM/nucYTxZY/OBC7J2bTBVuZxQ4cATLoivFcR3ontv5yuxuxb1ufbACrD3EM4fNlmy8ImIb5
 J3UrbMQSe2Lqw74LAEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040073

On 9/4/26 10:02 AM, Konrad Dybcio wrote:
> On 9/4/26 9:09 AM, Neil Armstrong wrote:
>> The console port (qcom_geni_console_port) is a static instance whose
>> uport.line is hardcoded to 0 and is never allocated from port_ida.
>> Only the non-console path in get_port_from_line() calls ida_alloc_range().
>>
>> Fix the qcom_geni_serial_remove() and the matching probe() error path
>> so unbinding the console device doesn't hit:
>>
>>   WARNING: ida_free called for id=0 which is not allocated
>>   <snip>
>>   qcom_geni_serial_remove+0x58/0x80
>>
>> Fixes: a53be6945f51 ("serial: qcom-geni: Remove alias dependency from qcom serial driver")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> 
> 
>>  drivers/tty/serial/qcom_geni_serial.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 3633723acef8..bdbdfd7dfaac 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1979,7 +1979,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>>  						port->wakeup_irq);
>>  		if (ret) {
>>  			device_init_wakeup(&pdev->dev, false);
>> -			ida_free(&port_ida, uport->line);
>> +			if (!uart_console(uport))
>> +				ida_free(&port_ida, uport->line);
> 
> GPT points out this will always return false before uart_add_one_port()
> is called

You can use if (data->console) instead

Konrad
