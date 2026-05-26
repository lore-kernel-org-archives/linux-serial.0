Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D071DED40
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779771991; cv=none; b=u1vU7FFguFhgRyOm5RLOvQLDJms+bAE1nPTlk2yF2p5oYAauNkMqNmdQmxOOtMVlWZ4eUaf3pUq7NjOGKQnvDQsvFLm9fEp+KRMULwWLE9V+MtgFrDiwVay4I4y0opTPb8zlRUwHtLhw9kX6FHqugPwyCK3bl6u/8ZU22yvPLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779771991; c=relaxed/simple;
	bh=CNyn68J5G4M9q4KLWttx8rNk0/rLkzFbuBx79srQ3mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7L+JdC2UHE8ndiE7vPwwN/3/tS6ER8OlYvaRH6IbCGCI6o09/VRIovvPCVMBV//uOAq0LM3rQ+WDfOukCxpHzJqPhK9a6HrX//E2c/vfXeTuRkf6V0lqp37cXSUUHzcGV1tBsr2tm2V9lXAhM8sLUcySArKFMtlF/DP+uh/YlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mb67mpL/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bb1O73cR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mb67mpL/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bb1O73cR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PGW0oV080260
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 05:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vyeclYrLbQjRr+lJ6lGO9a+S8wl5YIcUP6BYDVwCF68=; b=Mb67mpL/fX44Hpiu
	KHzcgtZjLMYk/mD+nL8xBrliSGTKWAOy/EZYMIlIrMa5zLQs1GoqsE691QBRnMrh
	n30by6FDs2zxW2xIrDEdnpn5oZzgZyFuvzlWDrjs+ZuMnK+ooVNML4OfhtbaMrlW
	he5/H6d9SO3kXp2KxbvfBM2S/b5QUWrbUKPIz2Toxy+YkSEkxd294BmViZofwdNq
	bXRWBftBqWSk2lITtIDOYmpjafL0f2KhojTyaa5SAE7ipc9OUFVhEoetXYgYOUU0
	2+LASQN8fWvd89xJV5Vg7Ix59H4Qlc2V0SPr5BShfdQLLNTHuKErN5pSSG5alyQG
	ysX6Kg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckmab11b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 05:06:25 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-135de949041so8980895c88.0
        for <linux-serial@vger.kernel.org>; Mon, 25 May 2026 22:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779771985; x=1780376785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyeclYrLbQjRr+lJ6lGO9a+S8wl5YIcUP6BYDVwCF68=;
        b=Bb1O73cRat3sEYtD/HoSjvyyisKgdE6a8j3jA0JuzwfGOr8lQmSyNrUt4Y8VED9k5b
         3kZm1xvjFbc8CuhqSnUBc3WOnoHtqoMxNWHgwx7tQ2q3qvKbKe2sq6e0HtNwHBxBV7sy
         4DfoCoNJodtXVvyMvvkgs6pOZDtXB7mS2jk9vHZrKIQTirx6eI3mkpaDbkIKUScfrQju
         jn5JV/ctKqwaM+FzesqLjZN92XsqhwGe/ASajjwLDcsUUpAxpP9mWg7D2UM5tMH8yRi3
         aEN6SingtslL4ac7RnALN47EXYji1PUah4dMVrquOIFvRyiuifQalzrRk2HTQtNDBh2Z
         QG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779771985; x=1780376785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyeclYrLbQjRr+lJ6lGO9a+S8wl5YIcUP6BYDVwCF68=;
        b=c0inP/jn/Z2LFhq3QY6JoNrOivu01dO2EoKlILbDSaFSrXFok/6LQFIg5nYA8F1z8Y
         Pf9ElrYUILJn2Ev9L3RkBz2jo++TXmOvZH+TpV2rICYKxPirAE6+d2/L5Wo84EXiKovk
         t0LsZxx5BYQG/uBq6eqUpuhUm9aAu8TFlASIAYJYqI7pytj+F3WfPOQCdB1iVAl3uqtM
         ucv2pi1PiP+HBOzidJNrDQ+6nThWHEmv06lGqodiieDy5TaNhaqO9v/ZiaZ76NsOK5JZ
         kqUTq+rbFk88jTgYuKdkzr/79spJURnWPKIUQJNWlYxuk1KVtZEZwO9Mk7x5f0w0UPdq
         GywA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZuJnsVn6/Wuu3eGv6aOjpNwcCJbvh3M6wEtVfS4gopjMDm0Z6bBsf8WKVwFAdOCPnLQTDn/X2WVwuRsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtbtKnLqB01j2JD4wKR+lyG5OF6O3QfDFaqf6dOLVLoqum1CW
	g3F/iibho4fgqX8yMLnSQMmJYvEUZBFqQmZnbS3XTYd+jCXXoYZQ2eD4UC1P7rV/HYl8Npybs6p
	PZR7oA4DvZjMu/Xh9mMZ//pMvgJXR6HWDEZsb406N2Q//864RiCzkNUTizJozvqjlHE0=
X-Gm-Gg: Acq92OExRA2FoXtffLqdPM45zJAMeHqivsB4VRxSsfzUaZ4DtkCfg2YB/BtAVtfYEp4
	owP4LKfyE2fL/v5U45CSuTxPEMaQd6EpejPqdXIYpk3ybJOCqvT1hyOPbEx6Rec8MxQp/NT16pe
	J6sLkh3PfRxIePISmF1mFCdHZtzTkUHFkQMbnZou5/fbaoox5os54nw8oAXANzuHnoCZpS6oAP+
	5DJasLgabsImlXcVqccIFJ5hVx3CU5jPe9AAIYojM9vrJxeNk08Fz99KGdRuzmvI7je9A9N7N7K
	ZWdkuQ5kammiEj6Z73cDY8UHaFL4iaIREQ3PCYy2eBpsERYPWgiHA6NEIKXnFnAMf3RdcSwHTvL
	45nFrVVzs1LxbkDAQKGsUiUW5e/GKXRPSm2OoBdC7RCO50U5BaOM3gw==
X-Received: by 2002:a05:7022:4b:b0:127:3f2a:af21 with SMTP id a92af1059eb24-1365f715d57mr5333414c88.15.1779771984825;
        Mon, 25 May 2026 22:06:24 -0700 (PDT)
X-Received: by 2002:a05:7022:4b:b0:127:3f2a:af21 with SMTP id a92af1059eb24-1365f715d57mr5333399c88.15.1779771984083;
        Mon, 25 May 2026 22:06:24 -0700 (PDT)
Received: from [192.168.0.6] ([49.204.106.123])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88c7esm7477591c88.10.2026.05.25.22.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 22:06:23 -0700 (PDT)
Message-ID: <c0daeac3-1c13-4389-b48d-92f3c3a1643c@oss.qualcomm.com>
Date: Tue, 26 May 2026 10:36:18 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260518-add-tracepoints-for-qcom-geni-serial-v3-0-b4addb151376@oss.qualcomm.com>
 <20260518-add-tracepoints-for-qcom-geni-serial-v3-2-b4addb151376@oss.qualcomm.com>
 <2026052258-scrooge-friction-fe21@gregkh>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2026052258-scrooge-friction-fe21@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a152a51 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=RqynvdPmTcCa9fdhPO8jTQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=reC4vt8OQQWefjZzLvgA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: 1cyJOMC0i20aPJ3LveBFzdko1egnUcvn
X-Proofpoint-GUID: 1cyJOMC0i20aPJ3LveBFzdko1egnUcvn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0MSBTYWx0ZWRfX9sy3dJuNV6Fc
 pNH+zRMxDEZarHoLBqint2QW6I4Zjzeh7kFrjN24zO5QjnCA2ADUhp2aaXy/TkOncTfgSRpxctA
 +og1ZBMKrj+wUIFVcu3lNJvdTr181NrW2B4vbm+SahyR1q8l4hw0dnDx6kNwZQNzWX8Gpyl/oXa
 wrS6JOuBF1C1IJBJxMVw2OExmJLfVsK0oYpupA/vqwRfA4Gj9iM+FMJ+Q7o+NArkjrRraZHWjUp
 HZKEYWrl1ohBXWWpfKi9QwLgtI1t8oGREMCQX0zMBWBImU5zbYQriMzsZBLcX5y0QNKoc313Aoe
 X+8mRiZjZVvcxBC9ebH4PbNm5hwYCwMiHf5URQvEYO1Gsf8pSAXki062V0vkxsmgN1Fz2FOdxeS
 PrVKmhiBeaDIZVTqlJoMtTFSbbAF4Sy2YPOaM4HdUAW203XaDjhbdH6e9p/YRh99XyM232xKKYt
 VkdZQAcQ048ZBGRYfHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260041

Hi

On 22-05-2026 15:17, Greg Kroah-Hartman wrote:
> On Mon, May 18, 2026 at 11:26:56PM +0530, Praveen Talari wrote:
>> Add tracing to the Qualcomm GENI serial driver to improve runtime
>> observability.
>>
>> Trace hooks are added at key points including termios and clock
>> configuration, manual control get/set, interrupt handling, and data
>> TX/RX paths.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>> v2->v3:
>> - Updated commit text(removed example as it was available on cover
>>    letter).
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 4 deletions(-)
> This patch did not apply to my tree :(
Do you mean these patches are not applied cleanly?If yes, i will push on 
linux-next tip.


Thanks,

Praveen Talari

