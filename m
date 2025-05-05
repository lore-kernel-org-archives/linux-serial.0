Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C31250C11
	for <linux-serial@vger.kernel.org>; Mon,  5 May 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447427; cv=none; b=efWPDk5fNL/L+ZeD+020aFMT8KU0fN0GkbXtIa6Wj6fvzHODXrzJggO24V62ncPWPMA0VdgoNEpw0WX9iovtY6GEjWaea3kZxwDgfYTEaf7ates4Am1m8sAWdZljLO9FsO84qXauHx9R+/woyLIEmFNJoyHaaprv60PXhRmKFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447427; c=relaxed/simple;
	bh=NlALIoe0iC3WSYUHgCo9Umj2JugDI/3o+WdAPXUGUuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m02v5rbmLyV61zrQcz1QpRHLCXnzx/N/+o4T2ylZgFQvbchr/7cwBl0ne4j4+GjHpoYouzqNggGh2WW6RFki3RG0kEzPRXt/hYud2ubE50/BvomAxVS/lINp21UlSlFNXT8ovbAQ6HJi0EtvZ7tDHw3sjeK0xO+C+ZNoHAcEebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NwwMaSql; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NwwMaSql"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5451R1nu013351
	for <linux-serial@vger.kernel.org>; Mon, 5 May 2025 12:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cBmlj28SvCZ4M7S1nnJEd0Nu
	gRbJw27zy6tWxbAN08U=; b=NwwMaSqlGyqRvyKGNJ4+C1B+9YKaFTYBTkNhornd
	2AOd2MXeKxG06zHKKNR3jr0sGT7YdDLBl0UiI17t9lhK1rK7ZHil4PlrTxPqONyt
	L+ikGsVhbN44SDGelGLeWz6jMuEw9vUu3zWMkhXx1y3eznr4EzjzExJpDi/FepjS
	p4/V9e3Y2d1AnhcLVjzH0u3h5bo3lAtoYoQWXXoCZp+8m/qZbmKcsSny5GONbOR1
	SKBmedWBK17f/h0Y5GDKY9Ta0H7bUiUBJTvmw4AUw8FrToMn6m7WfQAClFmzFin7
	6maa2wsCbtJBguMt74RI30b/CH9YNhBPniGkZe4F1Ssgag==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46da55v1uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 05 May 2025 12:17:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f2b0a75decso124556416d6.2
        for <linux-serial@vger.kernel.org>; Mon, 05 May 2025 05:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746447423; x=1747052223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBmlj28SvCZ4M7S1nnJEd0NugRbJw27zy6tWxbAN08U=;
        b=ZoPiLHASDx3xHCj+yQwHs0gc44aKcbiKDapV/KKVWtS+YPoWbpSJQkGo1RFdyuTtEv
         czv+dEXJzTY8HNoMxdXEJB2swKxCETeVjYUpG39OX3wC5XIPvaw8Kipj1bT6ZCaKu0ZF
         EhLBr9mat0HOhuJTRzzvCQu+z07t1ns5IzMAS+gAy4PJphLdMlwxD1QoduNls4D68ens
         SSjikVe2uAZeOCc3nhTK41ie6ll3iGKF/VrUNXsTe2bfxr8bC5qjiV/7VuHE/rgZsRjz
         SSRiRs/ZpJoch+On34InoQ7icGDyBNY+EamclJIkz+i1jrUhuIXZUn5jAs5KOQGgoYq4
         +z6A==
X-Forwarded-Encrypted: i=1; AJvYcCU8nuf1cMGmNucCSQrh6ySyM3aCVFu0SJ8DrjiWSXe7l4onY/X6Q0R6+QrWy69VfyynRGjcZPPn9f3t4fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1m9vzRbE6yarf0QNywaRd/ZVJ3NHh8Z6S8mn9hHAr1+GMPLxA
	aXHShhSoU2hONsiuuyxU0L+dzq0BUgKz2CglH2k6ha/bjpdAVavo/Xr+saii0YUmAr1uW7GKCd3
	XBf6uPCbzugGiXIDywuh5+RgbSPHsLL02ZnoxSn+1asSAmoEzZQEljXc2T6hpH/0=
X-Gm-Gg: ASbGncuaExksrPdQx97YGp34e5sZxsPP/URLdXVF4AW0hM49TqiHbmf2LaOXnJo9VL6
	PFrzGfM7B6GV54mYl4G/vWVw+RJkywIMsmoSS/4LJRak/P+u1ntyGM7z9BZ/iz0uiAmjlqBJhlB
	nodTjn1+UuooTxYnAMN3uVRwTlBNY4idqVVdEnsZL8Lq4kl0UbWnIuEvV9RrDUk8DQDVQcnCC5F
	wIwF4lgzq/6Pu417K/t5/NMTvJa2l0+F8NbihaUJCTyDFenVjHdqVyMwntCxvBN7X9CuYMQMiBE
	UBfU3HtVGaLJtAjMrIZWGvZTeFoJYV6S6OaYDNRYaLcp3xxh8dG5YRlKQ4TRy7y1rIPNcyKQns8
	=
X-Received: by 2002:ad4:5e89:0:b0:6e8:fa72:be4c with SMTP id 6a1803df08f44-6f528c36377mr90487066d6.1.1746447423069;
        Mon, 05 May 2025 05:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI2miDMGBi18VyNdPKWOTeIPliK5ntOZYPJ0fwhi2n4q9Zd33W6e8RHT8wR9jc3kvFT4tTjg==
X-Received: by 2002:ad4:5e89:0:b0:6e8:fa72:be4c with SMTP id 6a1803df08f44-6f528c36377mr90486786d6.1.1746447422724;
        Mon, 05 May 2025 05:17:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94b176dsm1684252e87.14.2025.05.05.05.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:17:01 -0700 (PDT)
Date: Mon, 5 May 2025 15:17:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>, Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: keep remotely controlled units
 on during boot
Message-ID: <aw6tjh5q6t75bif4jyusrdvroq53lbwlljo5cdgzrofn3a4loz@ixuu3yw4ucil>
References: <20250503-bam-dma-reset-v1-1-266b6cecb844@oss.qualcomm.com>
 <aBh9WL2OMjTqBJch@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBh9WL2OMjTqBJch@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDExNyBTYWx0ZWRfX6gAjG9wxAEv8
 epzjMdvWwxwEK8MAxtdKU/vBpadWFjvdAvVdr7PkWnFoBED3VcMTOCzjEn3rhskvKrVvJ4sc7D4
 vlAFXCFgDVhT+qlJ6Uz+Lte4wVeBa8pkDYxH60rsUg692cBAskyJxgM6D1Ha1Fb0sYncvAa1Kyr
 QyZTd6m0YGg6WtltbVggrtHQqAaGAyo2NWV1XZcFTldN6a8NEtTmJmOr6iOsENMyzn52/cWhBYz
 igPqPot5D0YoPzWh+HVAhycv2RbXFRQZ6x1zqg8GuM6jyPlKTKyCcMTlVfsMku4JkYmAUP+YJzk
 0sQ+NeGotrzWiKEBZWmr58scaK+ZMOTu0rO99vU6YrZ+EOGhLWHZBCU9qfoacPui/KpLMsU2ztp
 QqfpwxAsqGVCzBbyBf2TKu+hsP+4vD5EXsSimABwySIUn/fr3chrdZ4tzwJDWbb+8BuwIPJ+
X-Authority-Analysis: v=2.4 cv=M9RNKzws c=1 sm=1 tr=0 ts=6818ac3f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=-oSGpTHasqKTVeQyqFYA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: abWroefpqWIT9Yqj_myiUWUIw-eOGIH3
X-Proofpoint-ORIG-GUID: abWroefpqWIT9Yqj_myiUWUIw-eOGIH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505050117

On Mon, May 05, 2025 at 10:56:56AM +0200, Stephan Gerhold wrote:
> On Sat, May 03, 2025 at 03:41:43AM +0300, Dmitry Baryshkov wrote:
> > The commit 0ac9c3dd0d6f ("dmaengine: qcom: bam_dma: fix runtime PM
> > underflow") made sure the BAM DMA device gets suspended, disabling the
> > bam_clk. However for remotely controlled BAM DMA devices the clock might
> > be disabled prematurely (e.g. in case of the earlycon this frequently
> > happens before UART driver is able to probe), which causes device reset.
> > 
> > Use sync_state callback to ensure that bam_clk stays on until all users
> > are probed (and are able to vote upon corresponding clocks).
> > 
> > Fixes: 0ac9c3dd0d6f ("dmaengine: qcom: bam_dma: fix runtime PM underflow")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> Thanks for the patch! I actually created almost the same patch on
> Friday, after struggling with this issue on DB410c when trying to add
> the MPM as wakeup-parent for GPIOs. :-)
> 
> How is this issue related to _remotely-controlled_ BAMs?

My understanding is that for locally controlled BAMs we can disable the
clock at the probe time as all the users of the BAM will be probed
before accessing the BAM. In case of a remotely controlled BAM there can
be a user (e.g. UART) which is running, but didn't request DMA channel
yet.

Please correct me if I'm wrong here.

> The BAM clock will get disabled for all types of BAM control, so I don't
> think the type of BAM control plays any role here. The BLSP DMA instance
> that would most likely interfere with UART earlycon is
> controlled-remotely on some SoCs (e.g. MSM8916), but currently not all
> of them (e.g. MSM8974, IPQ8074, IPQ9574, ...).

This probably means that the definition of the flag needs to be
clarified and maybe some of those platforms should use it.

> The fixes tag also doesn't look correct to me, since commit 0ac9c3dd0d6f
> ("dmaengine: qcom: bam_dma: fix runtime PM underflow") only changed the
> behavior for BAMs with "if (!bdev->bamclk)". This applies to some/most
> remotely-controlled BAMs, but the issue we have here occurs only because
> we do have a clock and cause it to get disabled prematurely.

Well... It is a commit which broke earlycon on on db410c.

I started to describe here the usecase of the remotely-controlled DMA
controller being used by the BLSP and then I understood, that I myself
don't completely understand if the issue is because DMA block is
controlled remotely (and we should not be disabling it because the BLSP
still attempts to use it) or if it's a simple case of the clock being
shared between several consumers and one of the consumers shutting it
down before other running consumers had a chance to vote on it.

> Checking for if (bdev->bamclk) would probably make more sense. In my
> patch I did it just unconditionally, because runtime PM is currently
> a no-op for BAMs without clock anyway.

Please share your patch.

> 
> I think it's also worth noting in the commit message that this is sort
> of a stop-gap solution. The root problem is that the earlycon code
> doesn't claim the clock while active. Any of the drivers that consume
> this shared clock could trigger the issue, I had to fix a similar issue
> in the spi-qup driver before in commit 0c331fd1dccf ("spi: qup: Request
> DMA before enabling clocks"). On some SoCs (e.g. MSM8974), we have
> "dmas" currently only on &blsp2_i2c5, so the UART controller wouldn't
> even be considered as consumer to wait for before calling the bam_dma
> .sync_state.
> 
> It may be more reliable to implement something like in
> drivers/clk/imx/clk.c imx_register_uart_clocks(), which tries to claim
> only the actually used UART clocks until late_initcall_sync(). That
> would at least make it independent from individual drivers, but assumes
> the UART driver can actually probe before late_initcall_sync() ...
> Most of this code is generic though, so perhaps releasing the clocks
> could be hooked up somewhere generic, when earlycon exits ...?

The spi-qup commit looks like another stop-gap workaround. Let's add CCF
and serial maintainers to the discussion with the hope of finding some
generic solution.

Most likely the easiest solution for Qualcomm platforms is to add
additional vote on earlycon clocks and then to try to generalise that.

> 
> Thanks,
> Stephan

-- 
With best wishes
Dmitry
