Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41BE3EEAD3
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697396; cv=none; b=geH6aEThOWegJc5fbPqcNSBtc+LZDYRS7+PeGc2PKTiENjzGvweIFkR3PDCmBsC5+toD7fGZp/1wSvpP2AOm+adtDsVuYhxKjHEV/r852aCzMftJZWz0JNWEOJCXUJNDZ8UMoM+/1Oouf0a0EarX2NyFooQXc2fRPY1sj64qsvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697396; c=relaxed/simple;
	bh=XlFMuI0tt1TzDCK08s/K5IKS2ZygzFZODioUk7NidTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHcytJV0D2Rme9hQ38znGJ67W47k/0/rmNcmN2es3SfcY7xla8dXwmnIqdr/w9MzO9cAoP8Z9S3NyAGIIn7et36QnfRiU9nv8qiLV9wWb+M67DRNhjKG4aGkv2p+Hve9t9VgpNTtQnppD+8XVz03Xh4xTZ31HfErtLXrMMBcSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FlhueFIq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ElA97vCe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FlhueFIq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ElA97vCe"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UD261734952
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 11:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p3p8UZiQiYzgvHo8G5UaQP1hOS/PcyfF1lP3Eug0wko=; b=FlhueFIqYLtzq8Zj
	m97jXvggJttBsfT11thstLgAGmrD8ejPn4UQufDOFWizEZP28WT1Knfe22V/UK25
	ITd01OReoXRuwbnObrHTVl+UAN5bspy9PgyNnXVlkXNoxYSxVP8VsifU+7jNQMA4
	Z7/8xOGIMOseWMUP+H/4u+1eqwIlGnT87Cr8Yn4rbX1FZXXoBlD5W2hZql7NiBZ+
	LCGWBrb9BT5e6ERNtorPYKtQER8cUqjZZ+5UDyuJnMry4IpQ84k5/io1b+0oY6TE
	blNzrNICxkVH/1jxrhBSQvHLN0Q6DAtWko4tOupFt+7uPgZl/FpOE54TFFKWtqYe
	xes1uw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueemjyvg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 11:56:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91598af506cso562205085a.0
        for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781697394; x=1782302194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3p8UZiQiYzgvHo8G5UaQP1hOS/PcyfF1lP3Eug0wko=;
        b=ElA97vCeQT6jSZE/E/JcR7vONl1oirt/TF0V9GxIVMvSoGiuZLUZHPdRb52394BiJd
         wKX334765vsJdoEohp8ys1fZLuXIPMazjzXkKYLZ44Oo1lg6RxuuVIZ9dHol3bkErybr
         3db9Bc67IPtYGpgVpd+0s7ivnGzJ4hKjD8DL/HLCqGmH/3ybxWn4Ef6xKhHKZB5pBl2g
         SQIPJwZy1I4k2eu0o1o2NoHS5hGyQR/hDRh4OSx8wYfvN6zgI6YdzN+5KWNtfhAVkS+4
         mGUW5xerkbaDlMIKTj7iBTtPNZLGi4PUq67bAC5iJo+RMPF3P7SvMbMISzIJnlnM6FBM
         NDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697394; x=1782302194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3p8UZiQiYzgvHo8G5UaQP1hOS/PcyfF1lP3Eug0wko=;
        b=pki8Us1Jp63ygJ9wAnf72FjcF5KGq/cqZ/OdkH7OR2xqpruyz+40h0W1VWlmJKF7S+
         kCn+rfilQ1AB5riU/vFXSJTjuKyBKidhHLzdC7oQEzaBcGeyU16lIVlqthaxuyWP0e49
         st90QHikMaHBKFrj0N63zxrOah/GVlsCg79R3NmW2BTUlblOtMFAuRpRMbv96eG7yurW
         a2oplXupY5ryMnrwSjRekWF+MTqt8ImaW8T2JQCZzv8VGbiMgZ8Ibp1YZ3HUiji1QjG8
         4Lrm96pORMtHtYHpSV23g86yybw+4ifXPa+Y7fUY28FF8qsUWXwkwTMvYkoOt3G2RKml
         KC/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/qoORGGN04QMMZ/66xqEnZX52KFByaNUclrnFJMdTbd8aWl0qFbDU7NnxoWJ5zmeSbYyQPbshgfGcSnKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0wCf2X+EEgSfL9//VJU+gLDccybmlLFFb9E2MHuk0q7Yskp1L
	Pj/wx8mqXxpitAs5+VCDLoXaAM1YpichseMBeyXfiEYyCMJa+1fGo0uA5PX/Bqt/pT9Lp1iQiV5
	3clgepkw8MTzVeQFYsrAREN6hKyKpcoiD4+HBAEUdoMU6vCQvRn+XBLbzguP0uXMpZ34=
X-Gm-Gg: Acq92OHN8TkDzuvr6H+WVKm8nkATJ1+MWOVgcTLBhaTNLL7ySdaBQgMhnPs/2W8fmxg
	/gAKX3ExICm/360XQbqqmbpzCXQnKcV+K1jLak5pRS9gL/VKKkVR3LSQ+u90gBDRjc2c/0jt5wx
	BJDZ97WAK9XnyKthLUHXuiaFbQ/8wFscifjH8wA9HYDbTmbZAee1EqHpmLPF4ga6rhg8SrXvov3
	ksEYG7J94WF7zQ/NJTsQ+BGKIaXqUonTjwYJXOupB3KMO8QzcxDgMoZaM+0eXKveG2DVfN9+Lgj
	OPKkcsmu5Uln8NXlAkPlaXUfrlkF0ybfNwceHmG4DKa9/NmXLUFU6LBjFRZ3OduEUF/OPKD8Y9d
	pGrF/WK5VQ5plQx3bQ2EcGMU470Cw9wX1hY2YijGlc7kJ6cKpxPDsfrw0O5acpQ==
X-Received: by 2002:a05:620a:d8b:b0:8f0:f1a5:680c with SMTP id af79cd13be357-91d8ccb5ecemr635313885a.29.1781697393858;
        Wed, 17 Jun 2026 04:56:33 -0700 (PDT)
X-Received: by 2002:a05:620a:d8b:b0:8f0:f1a5:680c with SMTP id af79cd13be357-91d8ccb5ecemr635310385a.29.1781697393384;
        Wed, 17 Jun 2026 04:56:33 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa3a4easm172487285e9.3.2026.06.17.04.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 04:56:32 -0700 (PDT)
Message-ID: <c8de9338-534b-49fc-a3f5-f135eb000900@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 13:56:31 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] serial: sb1250-duart: Fix bootconsole handover
 lockup
Content-Language: en-US
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>,
        Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605241623110.1450@angie.orcam.me.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <alpine.DEB.2.21.2605241623110.1450@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExMyBTYWx0ZWRfXxBt6gPNLxLly
 wMvqPd8IsDBit6E46dFm3RmN7uWqjQgXc8qS30cwebdtitvAO1iYwCD07zEjKKD2lSbwlmx9xs3
 aKWR/JHla5QpQ9sgzzkqoTdtLHcOoLc=
X-Authority-Analysis: v=2.4 cv=D4d37PRj c=1 sm=1 tr=0 ts=6a328b72 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-GUID: SuIseOV1mA0G2OKFPH5DlvEZeq3g5lwB
X-Proofpoint-ORIG-GUID: SuIseOV1mA0G2OKFPH5DlvEZeq3g5lwB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExMyBTYWx0ZWRfX/WLgiWeue3EX
 30FLNdAiYy+9YQp+ev81O5onJtjhxej8ZT0PwBAF7pDUbjdJyzNbTDZWZ11ZP+XFUVJlEH6sA24
 RE8z3FbSRdonqVyvpcwyXyDt0a57mZKqQSujc2SDA6iU7s3vcnF7ogRXALOx29xIZf0wYFhNLGG
 tkPA1cNCCm23R4jTLdIbkADCL21TD3ITcwQNug1HxcmXHJ70HzqauqR+3kgOjfIsHrIZ5h0BcVl
 Cy9tErd7inYqm08LPyayFU4CB83iInKwTNHjkxnOhhB1NoChIuLsjHATesAZ5yqUCCnyotfUWtV
 RQK9bZ6/OyCv6bDNYA70A0tYbUuIqCt3JNOTshGOL7mAugd9UQN5i/+bEE6xhG0jg2bL92u4+Nb
 NTXr2SyE5vcB7c7plF75lVQdsEnuoI1V7DEHTsl2RSuWboLjVT92W/IzApEcysph6hHNkKIto+T
 CLO1E78Fsu5DBpwyECw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170113

On 25/5/26 01:12, Maciej W. Rozycki wrote:
> Calling sbd_init_port() in the course of setting up the serial device
> causes line parameters to be messed up and the transmitter disabled.
> We've been lucky in that no message is usually produced to the kernel
> log between this call and the later call to uart_set_options() in the
> course of console setup done by sbd_serial_console_init(), or the system
> would hang as the console output handler in CFE tried to access a port
> whose transmitter has been disabled and line parameters messed up.
> 
> It'll change with the next change to the driver, so fix sbd_init_port()
> such that line parameters are set for 115200n8 console operation as with
> the CFE firmware and the transmitter re-enabled after reset.
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # v6.5+
> ---
> Changes from v1 (2/4),
> <https://lore.kernel.org/r/alpine.DEB.2.21.2604130338210.29980@angie.orcam.me.uk/>:
> 
> - Sanitise the change heading.
> ---
>   drivers/tty/serial/sb1250-duart.c |    7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
