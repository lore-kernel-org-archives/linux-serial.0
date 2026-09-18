Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377864F68A8
	for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738129; cv=none; b=JYCUVFndsON1xr+0DtXtmUS5FV+poLVyhgHh23SVo+DXTScUSoj44DY7X9deYGyNti0h70Fc5atHIlA8XTFc+CaiFe4n8tCf3Wwmc4dWNtkLxjPiJQ5g2qfo6IP660UBfDnxBXT9DSzNxCJUVYBvixf8nKqWTAwQfscUBoJ7sbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738129; c=relaxed/simple;
	bh=0mqNrxShipiFICcXr98YX9o1uYjyfgPLNyYCaKheHwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+i0on0aU/xChgkW1dtnoA5YEG79jBed0Ro1TRc+DI+8QY05LvGKv52kuGrMZMgL9Xs1gfBF8brcZhm3aMHFSvkxiGPrG9veqrLZ4x1k7keTo5NeWuLm2XIXloK9KuyaXJKRMdZSnMWSqW6HdM39UtduYYoZzZBDxODnNpUVB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PqxwKVkL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kvf90XTu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PqxwKVkL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kvf90XTu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDOoZv101125
	for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 13:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xL2YkZSER6VuNxGb1EqLgbvAGw0ENoWXZv8k8oaK/BQ=; b=PqxwKVkL1H8AIHZH
	amJco1cZ3bnsry+4VI2T1nrvGDyupOpfZBJbzd/3sJA6aZwbfN0K9dtCwtKjOT7L
	yg6cbyCD+o8W3eipf+Ywq0kJ/yeP97BKTqmahX+K1qJNsqajnrkKt4zqd3w/6l56
	AvF+iVc840AKKl8+CxTmF37hFXapZrjXMIkKnRn0biDY2+ZnEHUfJZ0MaiqlpUt7
	OVxM3cpH87yTPRxiMoRBMutdg+OtfhzqAkXxVAhIC5+4drQtQdLNsAs9h+tX6MJP
	TDGuvcyeih/Yny3NqwNaO20aI0zPtKWYinlJIM2y0JTswIBTp4/2Gp3LgBZ1FAFP
	c+yxCg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grq2kur5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 13:28:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso680274a12.1
        for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789738120; x=1790342920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xL2YkZSER6VuNxGb1EqLgbvAGw0ENoWXZv8k8oaK/BQ=;
        b=Kvf90XTuM9b+hOlQBrsm0NQ+EvisChD52l+q/7LUEx9Ca+dxT5Yf+/lwd0L56XpVuO
         JJMWftXURwtMAn9dlks7wKjlIBjhM5PO+7fS/CAAmztSsUKhhKIvxKV0pSfvHmPMCgb3
         3nVkVVg4vdLWTKRqXEo/zA9QSro5WwS7M3Qr62Iurwjj+lCzgiQjtMHixDeKwytG3oYe
         vG5OiEqMAZY+jOBJgSspo2w2WaLi9Ilc2FQopnwh442y6lgMT9AGKri3DFaC6vaXl5ub
         XbXISpgVEq7WOu6pYU8z0g4S9T43Q9+czTtSLsYyeN3/l6kfZWH+bgnKoE0AQuKo1L0b
         ZpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789738120; x=1790342920;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xL2YkZSER6VuNxGb1EqLgbvAGw0ENoWXZv8k8oaK/BQ=;
        b=qKZAoaY9WnFWFfRad+uOeS2PebG/GGmRbTEI6189QIjGdvNP6I3elhPLr0YKIiMx3y
         pkabdD/9mGmFOadlJMXyGCeLSa7id0IlhEIkv1YxPh2ZBBIvlV5R4/o025pwGcju05NZ
         pFCofIGDXOIZ07ZPbmvIJPS9+EJ25rzrIX2KUHB0sSW95GwSUF0/HKhF2YVxKQT/Uxly
         jAEnyIjH+X6IZOoITGxt/grH2lExUYqRXPTTDLAO3ARybJ8P7SAtNe0jldNiRd3l6dsC
         SEN3a4dA3+/OHrRtK2ooOoueNWhRP8LHtIgRmaJzP72FPkqs23KjSg3bxYufuR39zNTr
         L7XQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLwxtMsO8jL8M69CkNdZ91nPjglhaqdVgxzB2GP6je8soYCujo+6oYcfFrJbw1ICB2dJwjcK1FqJy5I9o=@vger.kernel.org
X-Gm-Message-State: AFuF++kOPF3A1N/S11f1nfUbGBWmqLJ366dAPu/hcM1PftTrAdq3e0FA
	AaF65cewaZuT64tKw/QA0gz4oTFuFIEqZUKNKCNTOsiZfWu8PdGI0yjJ3X0mhw8ZH5BTMQA9sL9
	Z8M0wFlmx4GmIRLqCQyhdYmI7fF2Rbwh/gCD93Kli7eYfgsRz3wPTrzvdFv1dsnLMIXE=
X-Gm-Gg: AYBFou1MwhAFmdXbWtLe4tqapuZVqHB5KKkCLMMTxEaEdxYehPe9Jj2sAu6ZGoy4fD0
	93rROycTt4/LOYPxF6b2APQonWGmlAcM1rY3zKosrnKvd/kEFfcV4w0ZlAMyjuXEjFzV8WZhlzZ
	QOhvQrQtrVk80LmpM60Mhe/p54z7u8v9rCO/B/rnJSNXWTr8w8qke5HyUDevEu9ybsoy1LioSo5
	PtOKFYp0WVa1E4NQM/dWNsgGJTi8omcEjv48OvlbSQaCT3RFR8BHeo7vchcPI5qfgz6osbqiakp
	5ObM4/kguRahPUri1WEcbPDPfNp63K4gZrsgUGdoNFb897D7TiRrzDKEeVTXgxUfhIVlt2abQ3/
	8XxSeu/8wbl8u6+Qi5PNAZcnpNJLwjQw=
X-Received: by 2002:a05:6a20:3d8d:b0:3da:6bdd:2308 with SMTP id adf61e73a8af0-3dd8c4ff25dmr5563114637.18.1789738119775;
        Fri, 18 Sep 2026 06:28:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d8d:b0:3da:6bdd:2308 with SMTP id adf61e73a8af0-3dd8c4ff25dmr5563041637.18.1789738119076;
        Fri, 18 Sep 2026 06:28:39 -0700 (PDT)
Received: from [192.168.0.8] ([49.204.107.98])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc5c50c7df7sm940022a12.19.2026.09.18.06.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 06:28:38 -0700 (PDT)
Message-ID: <54d820a2-5fe8-49e0-bcfd-e2a7bf4df7c1@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 18:58:34 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: qcom-geni: power the console back up on system
 resume
To: david@ixit.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20260918-qcom-geni-pm-v1-1-cb587e215607@ixit.cz>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260918-qcom-geni-pm-v1-1-cb587e215607@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE5MCBTYWx0ZWRfX/YaZ96/faVWi
 ix6Si5zSUK0fEjI303HL+mDuZemd34hXfHmuMYFeMe/xw8UwDl8aRu2VEdp3LOWQrBBg7Y/9uGv
 OxoX8Yy4qzprm0Y2c4bCMAoxDmj8Vj4X/CojjFTTxq7sN//3Dff5WwFAbDtUJkgHGxjHDZU6np4
 GggdEqVTSoJChOzD5sivFkG8lqHB63lhGiTOHcaWegNYGu1eB+Z4IcEnCwPBBaNwUO+C7UTjIXU
 KHE9QCK2mc33ApYQXbkQKJhV0lAFM/MaqIvO0qWk3L0IZzg2PmxyHe0WY4Us1vjKl+nUh7R+6tq
 hiJKdLrJQt0ce85XSe6S280rcKV3YI6TKPeB7InDUUJgT/f/rnFLwBt8Pkn9aXpPBLKacPqmaPd
 lVvQzT3tSGU/s32j1UUKQzcRuAond17MBRta8Pygu6YG9QOQY+C0d0YJdnBkXpM6HTTl0MidXxC
 RW9YNBTPlK5MrChPgQw==
X-Proofpoint-GUID: GAyATq4CKOaBhm82egtHOUmscxeUiXeJ
X-Authority-Analysis: v=2.4 cv=bcD+w+PB c=1 sm=1 tr=0 ts=6aad3c8d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iAbW5UDHuEYo0+mR4LaZEw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=qMlWYKLyUHetfa4BSj8A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE5MCBTYWx0ZWRfX9NYvSOPN7TW1
 kfsdUUxsX6VZntgyNz/G92a2ZCZKxrtxpmJMlE2b/e3uH5PBIhhfdh3p/SOMrp8FNcceScwgdUQ
 7W0jusBRPWgZtlFX2UvzcZj3d/pLcy0=
X-Proofpoint-ORIG-GUID: GAyATq4CKOaBhm82egtHOUmscxeUiXeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180190

Hi David,

On 18-09-2026 03:44, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
>
> The console holds a runtime PM reference on its port, which keeps the
> port powered while the tty is closed. On system suspend
> pm_runtime_force_suspend() powers the port down regardless, but a single
> reference makes pm_runtime_need_not_resume() report the port as not in
> use, so it is marked runtime suspended instead of being flagged for
> pm_runtime_force_resume(). On system resume the port therefore stays
> powered down while uart_resume_port() goes on to program the termios
> settings and re-enable the console.
>
> If the tty has been opened before, uart_resume_port() ends up in
> startup(), whose runtime PM reference powers the port up again, and only
> the register writes made before that are lost. If the tty has never been
> opened (no getty on the port, /dev/console backed by another console),
> nothing powers the port back up and the console stays dead after the
> first suspend.
>
> Resume the port explicitly before uart_resume_port() when the console
> was force suspended.
Thanks for tracking this down. I'm trying to understand the resume flow 
here.

In qcom_geni_serial_resume(), when console_suspend_enabled is set,
we already call pm_runtime_force_resume(dev); before reaching
uart_resume_port().

Given that, could you clarify why an additional:pm_runtime_resume(dev);
is required for the console case?

Specifically, is pm_runtime_force_resume() leaving the device in a
runtime-suspended state despite restoring it from system suspend, or
is there some interaction with the console's runtime PM reference count
that prevents the port from being resumed before uart_resume_port() accesses
the registers?

A bit more detail on why pm_runtime_force_resume() alone is insufficient

would help understand the root cause.


Thanks,

Praveen Talari

>
> Assisted-by: LLM
> Fixes: aee1f94dab13 ("serial: qcom-geni: remove .pm callback, use runtime PM in startup/shutdown")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index a180a00c9e23d..0c9164a1fccda 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -2100,16 +2100,22 @@ static int qcom_geni_serial_resume(struct device *dev)
>   	struct qcom_geni_private_data *private_data = uport->private_data;
>   
>   	if (console_suspend_enabled || !uart_console(uport)) {
>   		ret = pm_runtime_force_resume(dev);
>   		if (ret)
>   			return ret;
>   	}
>   
> +	if (console_suspend_enabled && uart_console(uport)) {
> +		ret = pm_runtime_resume(dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	ret = uart_resume_port(private_data->drv, uport);
>   	if (uart_console(uport)) {
>   		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ALWAYS);
>   		geni_icc_set_bw(&port->se);
>   	}
>   	return ret;
>   }
>   
>
> ---
> base-commit: 3d83758432b5e6ed9507500a57efb0f3af41ee7d
> change-id: 20260918-qcom-geni-pm-e0ff5899c948
> prerequisite-change-id: 20260828-serial-qcom-geni-fix-unbalanced-rpm-resume-814e630326b9:v1
> prerequisite-patch-id: a2666a59a68190a3f438cec8aa167111c21dc8ca
>
> Best regards,
> --
> David Heidelberg <david@ixit.cz>
>
>
