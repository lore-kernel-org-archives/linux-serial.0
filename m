Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A24282F27
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 03:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786331696; cv=none; b=uH1cECVDdRa9URmTrCEfyn7pre7G3R/7N72uXlIBn1JY/NOZOtVhW0pZU3cFBu3bpEPlTOCx7E0YOC/M5hQZ/XeZadtTo9I7blZPpAYu3sArF1fFh3fva0PU+rLtC0C1UedNKKfV9dPY7DVheLdunD20R7WRSZyqUHh9rnOGFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786331696; c=relaxed/simple;
	bh=+sec8ErACzYjJLn3AV+BPMhgRPD+TGuwp+pbNRFtO2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwhOr8coJQEi/1NpJ9NHGN7eYEhW+s6nWw3DzQjH56PZ2v+j5Jfl2xxqVtj0MM+Da/nldWqFPvyGgCDt4pqwftBSv8SgQUxJ0oKtV0cQUfymi7jcROTCS3JHdAwFxZRez79koAMr0L4ngTp0gJBWsCgCpBfeijP/U/WaRP+BzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d+2IQunS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OXRSv4B1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+2IQunS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OXRSv4B1"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679L6jFk4105757
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 03:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4OnuEW9j9G53ye+24dR/fC+FjzepwpRCFeVct6gvdhQ=; b=d+2IQunSX5veyokB
	Cgxkhn3WME+lIiMPyVsPlhOhOWylbFKvyZ7OW1rqeysUoGANkm5cifxW+VxewGA/
	CYPI4k43x7+tyyC3Ifw6KNEA5JXR/TSuhg6mKjFnZoidv3frHsJ3EL0jX6hAPuRy
	73T3O3Z3ioQWrUzDlotMktYithkadz95XVsW0EBrjZ9iV/q7nHAaSEQxS91K3cJC
	QwuvPVFa1esgBAzzTelzXDCQJKQFgay3TunzpuTlqiuOmIrE3XKBUs8VUqQP10qh
	Kzx4nIbuH1BpMLKdfu6cjwKU0a7rSW6z1mW32YjpnV2Wi5I1ibJousCxg/lFdDKF
	GRdv8g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7c8fn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 03:14:53 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90a3b6281c6so4265616d6.1
        for <linux-serial@vger.kernel.org>; Sun, 09 Aug 2026 20:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786331693; x=1786936493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4OnuEW9j9G53ye+24dR/fC+FjzepwpRCFeVct6gvdhQ=;
        b=OXRSv4B1tuU3z2BrqvQBHfVDbSnqfAiCwYH7d5g0uNyrMiQc7vQeHnpREQSAbRT4p4
         eGq0w6CUJoHT8fY2O8kCCI5KntziJQwCs8c13kyneCAAJGNxBusNUoFuBPampHUBmOcZ
         uBIndTX8cEIVzZFKg8OSNLOC2/PqT0ztfA4BO0tJrIjNehZGnRw8eIrB+y9jCbg/PRGr
         SeaBbbUsC/86Uk/QoLFAUnlxJqCdx7ChH9Y7otQ9Q5HE0ERwce9MY1J60Os1wBNvEa5c
         XwmOto2ZFXXzliWvGfv7Qz0vIJK17ogkHxlaE2+DLzDJrkxZ2ib7nGdROOc02DvE0uqn
         DXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786331693; x=1786936493;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OnuEW9j9G53ye+24dR/fC+FjzepwpRCFeVct6gvdhQ=;
        b=l/mNCrNSIZaMoeRL4/6hOrnstVY0yYtR9I7FQ5skvWdm1R03eRmkkkO3I6DEIcPOLX
         hngJW9zNQI0/xPXA/ZBVloc/qsFS8MDENqI0qmYYFTsbmhDpRW9IME8TSXEcjG6XgNHm
         Eak1tEwjCnhcuLD5VQUYc3/nijIwW6ZiK9O2OsG4D26+cXOt7D0V0ToF0KOIm/1+fNn/
         h1Jfyio+umpzEPcgLK6GkHfvfNgENFTacSSXFNgB8YfE9WiuL9r/SCORt1gnpWb4MGna
         3eYJ9B6XO8Iny5EQ80SDDwE9NFc77srROOb82vTVMaNPY1tOsUSSnP8DwwAQJnwk8VZk
         ZUOA==
X-Forwarded-Encrypted: i=1; AHgh+RohVvH37tPz/f6brZyR+P+nwIAYQTpD5KBBWWmM1GsCQ8Xu70y9CTTyFmP8FdFwUjncv2RcrN1UsPfMQ4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWLG6IWrdEPzc8TR5X8X8yF+hSs/Vz/Uc9PGr2yYRyLPglpFe
	3YtRBFIRDuTLD9IGH28yJsJN8BEc8c26bHII/mKpMvKvsuerECJ+4HfnJtzjCAKCnxjCDCDZBNr
	cN6Ad9f5onUx7ccVizXR8/lewZVMhnisGAZBkMaR74DMFxMQDXab1W3rsbldATZNdT2A=
X-Gm-Gg: AR+sD13GEwMfNK4p7pbMat8w42hs+SJSLoO9PgYLVfjGKJaXfLAW39lnEfNC3Cuh26X
	Qa4qNXTQtRbwRKkYyQ1dZPzuhN2C8HA4D7ZQRBQDuNU8PxSEz6voz+NUKDRVI5UrrrSzQqteKNs
	b/sYGGNlc+nbrItIMaaWrMACOAS/cS3ATbWGX3z6lXhsb47dI1T4pN+QZIFPYRz4wjyz3WwMCZg
	7mKBQXOkJdrhIxqUUxMIKm5JZ9jmHoT6K28bzBOWq3cLzp5CtoyG4CsMKTPrbCX69iMIq7Aa1o2
	Kz20KoTLjj4SBeHJzdIHMJ1oQr8bCbluOPhAJMjRwPS7myDotupif6dkgqnp4X7635mmaQ9GL7z
	apWj3sMGic5nwzjLftDsLbolbBfIwzlJ0pFw=
X-Received: by 2002:ac8:5a50:0:b0:527:69dd:5413 with SMTP id d75a77b69052e-52ce5f8f737mr414847611cf.5.1786331693317;
        Sun, 09 Aug 2026 20:14:53 -0700 (PDT)
X-Received: by 2002:ac8:5a50:0:b0:527:69dd:5413 with SMTP id d75a77b69052e-52ce5f8f737mr414847381cf.5.1786331692935;
        Sun, 09 Aug 2026 20:14:52 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421fee8sm332112825e9.7.2026.08.09.20.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 20:14:51 -0700 (PDT)
Message-ID: <b28c7fcd-6851-49b5-87f1-1a779c61ef62@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 05:14:50 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] MAINTAINERS: Add self for the sb1250-duart serial
 driver
Content-Language: en-US
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2608060423110.55540@angie.orcam.me.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <alpine.DEB.2.21.2608060423110.55540@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyNCBTYWx0ZWRfX69KmSAoYlIb6
 MdmRRBoARfPUhrMhnVH9uHqRswmhg+IuVqbwL3E4u3QGe6rkq2UG9mL1Gn2qAyTUKSh46hKUPki
 ok8+bojNW22BCRCVNiCbVQoE0yHZpdo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyNCBTYWx0ZWRfX/ijJ1BCcl006
 NmOUdklZFd8hZGlQa6eFGDHlbhLt9SC6esNXl4gfRgAMXDYwvYvUCIw/kq337jqTfx10M74IuZN
 fmrRlbp0CyZAiydc0ahqcwjgYaKxzoOnEwjzMjeQeJGDXzgeLzg7fdpDIeYv0Ps1JJTkr0YSBQy
 zRDxFiFXbFs13Qav6Xm0NuLUzQhJ8htComeBkRM6RiOo3RvSo6WSJegqG05oNOYL4IrKg+Jgr0P
 wYbk8XHcdFazWt8KoeyuPrcWUvrZwSe3ddkMMdPbm8ukhjsJbYs1+cTWQhsgdr+FQWqd4Cg7z1X
 J2fe7QL88FwbAZS9vXBGc7rc8hxxwKpGg31vV1Tf08e6EXujFRaQNI1J/Y/XYTJPbVLAD7jtKP/
 rkGXRL2FaBtZGtmZOLBoTnyE0Sr+6Jtp1QGI/6sEXAS3dmqeVf+KiRClQhnVRH9iI8qhLRvhB5G
 UwFMRHxvSxyh9KfxgaQ==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a79422d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-ORIG-GUID: o44ZkeVxF8i0cGnh2YOgP2OH1i_68DFz
X-Proofpoint-GUID: o44ZkeVxF8i0cGnh2YOgP2OH1i_68DFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100024

On 6/8/26 12:54, Maciej W. Rozycki wrote:
> I wrote this driver and seem to have been the main remaining user now.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> Changes from v2 (6/6),
> <https://lore.kernel.org/r/alpine.DEB.2.21.2605241637170.1450@angie.orcam.me.uk/>:
> 
> - Post separately.
> 
> New change in v2.
> ---
>   MAINTAINERS |    5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
