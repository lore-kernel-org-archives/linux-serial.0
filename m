Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EFD24A05D
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697701; cv=none; b=o3qLdIaRaJ//CoMdFUNNXkZ3TS3huhm19N9Zstsdttk1VSmolY7gsjBNO+OlqNvDoCKLudQXkB/eTgy1nnN7WpIFQ8Da7vOYGIupMoghjGgdRZa2PePXgwr3ZidIDxKQDr31u/+khncY8GjSsPf7cqkXcTyBVYA5c2OkTIxfIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697701; c=relaxed/simple;
	bh=M+n4V2JDJwQRFCwqQxBU2IOmRIzxuEpEbI/ucRGLaXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGY+rzGbOwSMSak6eQ+W776P/cWUV9HSEWtNEjZRfbEcZcln6HOhAlDXM4uPBxB6boTH7DaAP01UjBl2YeGXj9m4aKyBtS+gtX0LUoWnPZCI6VsH7Fo6Cp58uizUAZQUsRKR4TD5FXzBj/2N4s4OIWP7wUv4i+qlza4suHzTu/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NhXiDzof; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lj7PvKSH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NhXiDzof";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lj7PvKSH"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HC0u8H2747644
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 12:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xy+YRoc5S5toayk5HKQvHdzw4bucENxat3pUDhpI49Q=; b=NhXiDzofAx17IfSV
	OVtlyKgrBP57R0l70pk/KTxtQ2/yN4+NaSyT84YfX2+X+64yAxPYzFIwONOlJFTg
	A7vIpePhYguPkOeIUbeOrP0SRV0KFfq9g9ZTU1jBWJdfOjqDMgSoFkMrI5bCYPcq
	L3896cv44qohnhqO7NC/bJKFusnvjP7vrfdl244HaIbw4quFmeU7GX2Dwq5rwLxe
	Akyrk2CGi9AAbVD4PpNMQEE6oLZAYeAtq/FgWvZRHoP2TXQPdO5SQxlNwiLKCjmt
	X5se5BeMXs7szlpFmQpO5r4g49vstyz/WErgRmkRRwXUpuc7gjJrZqafQdOnkEeR
	+y9ibg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef2b209-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 12:01:38 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-440daf1956bso5253142fac.1
        for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781697698; x=1782302498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xy+YRoc5S5toayk5HKQvHdzw4bucENxat3pUDhpI49Q=;
        b=Lj7PvKSHIgL5svL3vSBuWl74jBrQ9bgmo9QEZnmqz3bq3Gq45OaezUXmrYaK5x2DGY
         itE9OPlVKa1PqgnAZkgo4w4zk5Pn78XGUZoEhIRq1eKs5Xgg3CZymdMnE7hXDqGmC/Z/
         dY9DmKbhwRa+QxaRogtgTWiI1Vsz81eVJZSOilE0hOn4YQS9dcXwHYyuj+tyAla1A6IJ
         ZJPWJrMPfijtkq4MXv83TL2Xciug2PX7iq/wh1Srj6bmXuVlVWhju9kqrewv28XBEvoC
         qltB8pYC//4aJlty5GNk0AyqWXoV9kyZjCk48rk3seM9VVCYQv38Ow7v0qBG+DVssVMT
         eD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697698; x=1782302498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xy+YRoc5S5toayk5HKQvHdzw4bucENxat3pUDhpI49Q=;
        b=ogttTzK6oKkHEeuSp0ywdLo7/zUiz07RF+z+ncvbbTg40I2zgzKGHoactPPV8nfqdU
         Yti+Zej4tT0NqVugDjPG/wW2c9m5VPr9T2O8fQWecPn4IE8T+6ZBdGWiE51gGCzLdGXV
         mhzP4FGANtH1PF/U3B99kllFRZzUnqS+Ws3b1PhrmM9ONmOk1pxdzKs8ikRGdXJReXpB
         2YVfdwwoeuevU4+gmdiGvMI+SIw0yn70WZkqpG+4WOLmkEzgxpK9rDC1YAAQ9j/rO1/g
         g58g/6EinEzi7LuVrGA+7FURxRWGTBE/BtB1H1MGtm4XcpOdSBgXGiR2Tv2RVzwIYHZP
         gTnw==
X-Forwarded-Encrypted: i=1; AFNElJ/YQEwrzqdXDWpxb7KXAyLs+eoPA9DOtzUj55SJQLPFm6wQ8oHkUY7um/JAhIg92JsS/cb4+W+PizYl9oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmgi2miu/lBmUg23izp4TNs4Khq2g27GtKgIOme1sznhljV0z
	U4GoIJAKoyn9/yruzaOMm3V7DCjpYQOyjp4HqU7N98JLSnFwWZPs3eMOTpUQJ30zJw1R+jo1qLB
	kGlGTF+sImIqGBQGO+lFCn24ZGYE/x9WWlyKWBr3EseAyBVzlaewbubUsck8Bl2x7wcf94MGgUe
	4=
X-Gm-Gg: Acq92OHYBdlqCDphka8hlKJEyN5yDy+IApY2GxldLc9NSLGz/kGaiZeX2iBb40NIBPL
	VKwCEHJ2FlJJ0Khc6HGlwLCHldG9zmcRI9powFHdipBJeCWmUAvnpQtYk3HOChWJPfTmhi45XDx
	fCNIx8y6k9vfHy+m7HfUYCNwE/haPf9eJ2UIj3G37VwYRW+s301cJpVK5uGFs4WsfMnOekMsbBN
	0clRnecZ+40NHFOZaAfHH1m5uf1D1y9HK97buk+axm8Nf+JcZicTns097+ihZXKY9tLLWhAOWGJ
	73CZyr6sRsD3YAYAsLnXA5+qJ8UN5OgHxZK4sSzFct9Qwv8HP6t5+QL2dB1/CbRRpm+eak7nt+x
	ME4i8CxV/CCSFV/84pZg5JieWnZuLuMkqLoKIfuJQYjQpO45Hlyz0JgW2sni1xA==
X-Received: by 2002:a05:6830:4491:b0:7e6:7dc7:4542 with SMTP id 46e09a7af769-7e90b3dff09mr3306958a34.16.1781697697991;
        Wed, 17 Jun 2026 05:01:37 -0700 (PDT)
X-Received: by 2002:a05:6830:4491:b0:7e6:7dc7:4542 with SMTP id 46e09a7af769-7e90b3dff09mr3306881a34.16.1781697697411;
        Wed, 17 Jun 2026 05:01:37 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-461abb44c3dsm12421130f8f.9.2026.06.17.05.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 05:01:36 -0700 (PDT)
Message-ID: <be85c5a7-de59-43c6-8f62-8375b97f38d0@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 14:01:35 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] MAINTAINERS: Add self for the sb1250-duart serial
 driver
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
 <alpine.DEB.2.21.2605241637170.1450@angie.orcam.me.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <alpine.DEB.2.21.2605241637170.1450@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a328ca2 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExNCBTYWx0ZWRfXyTE39HmRdccG
 3ADWxA8+Ucy8DJ1CjvvR4S9xw5nmZpzscCr7tADIZ9+BcEFPqqVA+O63AFzx++YO0xUBJDYcN/5
 MUotIyszNoJx4MEoeqWX39xpFwmlFVY=
X-Proofpoint-GUID: HPeg-lhhjZizc7z0A_KTwwpAPd6D1Bfy
X-Proofpoint-ORIG-GUID: HPeg-lhhjZizc7z0A_KTwwpAPd6D1Bfy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExNCBTYWx0ZWRfX/eJcbP3W906Q
 KNSs0kc6U0qo7D5wzxFwLk69KIF295HWoEsB0TtnwSUeRdEG/s5Cm5CUT4LY+oFzdAJl/H1PAQc
 rhPML9IuJ4qHSosb5Qk1UuxlClGpMP65FzW6gWALF6gshdANKfjoTIV89do1i8n/5P9p95y7RtQ
 jGpQBOrvGW+JC8qDh4idbj1Dc6K9ZSYNReExkcptVqdlnw6aDsyjf+839VP3iILL15IMTF/qscu
 qfvZpnQIeWP6B5pYpcgC/vyAlAETCFuSLC6REtId1uu+Uy8ST5B1Xtg6ZlTvCZ+9qW4bROGe/ZO
 TfQjuPDkDwKEneviqBWePBDmm9Tek6ZXvSSxoGeGUEQ+PT4P8E2teJB0tulRpMEpteHkkfxiTHe
 7dAO5AK8ZXv5BfImoL4BdS/BOJGcAnvuzgrMmrJDKjD/v2+zfOYY7wnsPXMU402LA3mPNLBmF9U
 EWFCWWFY4HTfqVH75yA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170114

On 25/5/26 01:12, Maciej W. Rozycki wrote:
> I wrote this driver and seem to have been the main remaining user now.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> New change in v2.
> ---
>   MAINTAINERS |    5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
