Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A6283FF5
	for <linux-serial@vger.kernel.org>; Wed, 24 Dec 2025 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766560243; cv=none; b=tHmy5PyIx1oNuw8BOF013B8LaMowPeP+pVIUOLtUVMGf6dIUGU0a4e/Ee408vDjGBhc9zm18BmOvwXsOU18Z83hEj6QoQQ0WrroJigf/8mL4Tyaz9JvHhWWW1wPPS1Y5N/hwEND95yOxcfr8h/2J7Fm299O+FwK0HTmFqbr3OLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766560243; c=relaxed/simple;
	bh=7A5dqrMOK0w+O/9LCKXhmJ0MZxcWq7Nmd/wG7Ogf/v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6LBNNkiinEqTkah2ou8L01EKTEXnGfWUTXyIdaggjbhCmDocEzcNlTgcXbjF17gxRo7fBnej5ac2bSKOcXSNYZDvIFp9NAtxX8qbUys0hAQHZzPMleZBuOabJZHP+Dg96XKQkdzn5y5h65sBpzexLVt/GHPsbNAnRAYiEmZjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W8lV7157; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ijl5P+z6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W8lV7157";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ijl5P+z6"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNMhuOE1801684
	for <linux-serial@vger.kernel.org>; Wed, 24 Dec 2025 07:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	71gXKtFW7Gx6s5o4kXmxuGUOzAnZR1zYbg0J94tOxuk=; b=W8lV71577kokZIE9
	VHIE1D68vmYiVEopRprRRcRmoQQQtFqBy2GgyWFHrIxcVWJ33U2cYYzYcqZ01p3H
	O69x10bn1kWL1WdYfPmLvLU1m9w28hqjUgRG01dh34SJYxuwY6qKgc9JGMWpNMmN
	snbTebatHMcPJPZOZbWmMVTqFTicbJRlQn3AAWwn6phpwreRdR8yctHDwBd5FoeX
	PFsXkwtluQgdhfBl3N0WOL7yyfkaqHNu9s3Ke2x2M98rzNFSdZOC/tsao82rOx64
	44t6CmTnLlxdamfTHhhbqOT8qS5dTvINYvI+Bc/87pNtK9dRUKmWWWyBJjbr8uPi
	aABUeQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7xjsa3r4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 24 Dec 2025 07:10:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c38781efcso10951855a91.2
        for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 23:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766560240; x=1767165040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71gXKtFW7Gx6s5o4kXmxuGUOzAnZR1zYbg0J94tOxuk=;
        b=ijl5P+z6e/9pNDmh3J/rvKqyZGS/e7Y/B653jBUZ5MZkI4ftzXXFFtpteG85paaH4x
         1ESemLRffzvPfStGp8oNTHeyiOcTo6YXhU1RQ88Jo6zLBfKeG5z6mqbsE47YXi/i3Z9D
         qCMrs3PS71h1FnMMOwuTJ706erCrTlsZa2CukzF3KG3jLzKb8q0AtQbJKG5/F5dv0h2d
         PhQ8HmrSkEhw+p1By4p7DD5FAxAj3L8+U7gWv8ePrCeKxnZWzIvmlKm9VuxkHEc7wsz+
         9vuitLlwRjpoqXDLrBonk2/740ck2poo/tT0A6rkHxD0AcAXJ+82crghdNaoqxy6h6I2
         VQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766560240; x=1767165040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71gXKtFW7Gx6s5o4kXmxuGUOzAnZR1zYbg0J94tOxuk=;
        b=abtlvND2DV98KmsXEhvR6seycmWrNEmsjE3MWRjM7J7x+vOog8IBqzWmQEW4DhlCpN
         bK/X39Oe+X89L30TZWKmRtghw2deE9CJc263EzQe7MYx505L+Y7JeOndP/fCdqggMb/E
         Zpna9hBmf0V9P9ADOwN9DFkbKMG/joIV++/LHM1mf6hboSfe8fTpL+ibKSrqh37SK5c7
         Otm1rDx8SRaspmPjsoEbQXvZXk+hQWiUpif8tmAW4mQV9vrjfK85RLrqxySg+cu1vLU5
         YhjhXc5FZEe0hYSqKqVT1ZuvyfZUKILNbfjBAW81hpjxPRUj2mLWopo6ohwyIYdDMzo1
         qCOg==
X-Forwarded-Encrypted: i=1; AJvYcCXrDCas079OBK7zHBvkJeo8G0haQAdgS68WC0fmsNYZQllPZ2CsiGQmcEC4becx9el7Eoq8MQaIGT2xsbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG40UUurzCvM/uIaMdDK8bctGtbfcqZ15DwGXoTNZBmTyQ4fYg
	GsBTDrS4hea1BLqwJXs34dBwEdVql6nxqV41TrzrZ6objiskJbqxuYQP07KFiJEmtMtWaz/6jSU
	DpsV+K2JWzjxrj8LBfq+43Y49L6mm5z9QI6t8IIq74DL/fQK7KAcyq8N57lDS8EU3dPg=
X-Gm-Gg: AY/fxX7z4Aea4TbjBYJWTnNiassZKd7TgkPaYT2xJ2lltM+pIkeQjGHslj3xsTdvMSF
	eDPJOaGz+Z+KuUJZbORXZjxCfzU4unYZY0YzgcvBMXeU2Q2lVGKJ/5Iq9wYddQrt5Kr7qggGV0N
	+3maU9h3SEsJvWHVS82IaMwdnm48NXn6o5YVsOb/BPm5Hhe9Pk4q7FfpLHdWhIM6QPCSgQQPjfS
	X1Zw6on/CpXDFJaWr94iHNvLHbGJhMIqmMMpFAicWG28X/zWAUa51LZQxXv8fMqTOrX5OxYwX1+
	BA+6G3UUNx2XJwA8QcVk0Sml6mT5LQRxgMSo1x5X6NmXgmiCyLYNo0l/Dn29D/6PqSQW71Yk7zi
	QbQ6hYXg2eoG7O0m/2uU2DwDsDC54vZx7N0DtzLXRk1b17AgKUlRsXOMEIDNOOuXDIOr9YSgXhZ
	JkJmmH
X-Received: by 2002:a17:90b:3145:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-34e92142cb5mr15260130a91.15.1766560240123;
        Tue, 23 Dec 2025 23:10:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETyNPMDm3Y3pott9MwYCmEvde6P/jTze/LD6TVCgKspnpHFALg+ERFj5vn0NqfBMpF9mribg==
X-Received: by 2002:a17:90b:3145:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-34e92142cb5mr15260108a91.15.1766560239632;
        Tue, 23 Dec 2025 23:10:39 -0800 (PST)
Received: from [10.133.33.224] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bd61b40sm13978815a12.23.2025.12.23.23.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 23:10:39 -0800 (PST)
Message-ID: <18a5d332-7ba3-47aa-bee9-1e5f5b724b80@oss.qualcomm.com>
Date: Wed, 24 Dec 2025 15:10:36 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] serial: core: Fix serial device initialization
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>
References: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA2MCBTYWx0ZWRfX+mgNauIgUw/c
 M+bpRBAK2NRLUQmTHQJa37IFhw6jfx2DwbTlUl7CIlYLIYTjCNC6kjKqxRTNOLVsi1aCmRQFiqB
 MTWDr+AEVWttJ7JnnWqFCp8vRb5V+C54hJHyierOzBxbiCLF9UVKs7Pj9LZ+UoVazofMyGR8adu
 +0QWoOP6k/B8l9srznIh/NoXaJ1bvHB4aRT4dTXCfuhkKSTKWI1x0i+M8QnFIu+swawb3sZ2pbV
 8y6emJQ4UmqnDT0GBXj4QDt4dqA0bSIF6m/p4vbgUjjdtTL3QR+MOvTBkVAXUoMooH9JPQ3onUH
 WCgvtEvsQWWa3ZLLi5MxAvGgdYI2Ke7OBzq5IrrvYloTFOAPrXiQfjwo7w9wF/KLr3n9CyhNP5q
 Km8QBPlJzjtSJ5FHlLU5GhCn8C0g2LRPMN+acMdI6JwRBDOGKQuRJIoBHLt63DX2lioScvONE50
 P4TltMI4/4XQWIWlncw==
X-Proofpoint-ORIG-GUID: sBGeZo6SyfuRpACMrFnQO0dYA7G-HzYu
X-Authority-Analysis: v=2.4 cv=YcqwJgRf c=1 sm=1 tr=0 ts=694b91f1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=8f9FM25-AAAA:8
 a=9xdg8cEAAQnOrwX93C8A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-GUID: sBGeZo6SyfuRpACMrFnQO0dYA7G-HzYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1011 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240060



On 12/19/2025 11:28 PM, Alexander Stein wrote:
> During restoring sysfs fwnode information the information of_node_reused
> was dropped. This was previously set by device_set_of_node_from_dev().
> Add it back manually
> 
> Fixes: 24ec03cc5512 ("serial: core: Restore sysfs fwnode information")
> Suggested-by: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/tty/serial/serial_base_bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> index 8e891984cdc0d..1e1ad28d83fcf 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -74,6 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
>  	dev->parent = parent_dev;
>  	dev->bus = &serial_base_bus_type;
>  	dev->release = release;
> +	dev->of_node_reused = true;
>  
>  	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
>  

This can fix the broken serial on the Qualcomm Kaanapali device on the latest tag.

Thanks,
Jingyi
