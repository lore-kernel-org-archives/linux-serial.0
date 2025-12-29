Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6102737F4
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766978303; cv=none; b=olv8i9CwBqWJHLXPONULW/EC3ovoR72vCv0avUPD7VhBbKMQEEyE/CHiI3s1W/qEwhEuWnkUcd6a9C/z0k8hfvu0XCRbdb9YlPjudCLP2QTWsH/UDI97V3/gj5Vaxe2y7kJlmXmzMMh2/CH+YhGJmjoCvXA+yYXCSQNNX+ln2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766978303; c=relaxed/simple;
	bh=U5+tajyX4z37PiOhU0sqj51yXSZuLKFhmzkJ0pnOAJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssu/LYaPLQMd6Gb0H8ObvKH8cTmMF6FihutwMffTqjkJITnVfmjuh57HhNjcmR1GTMrbUJ8CzVs48VIrlgr+FaPAtE30DqoeensBpMgMrqKbMgIZ5VzVGdSwFWMfmPdjBdW6zshrYK/tLtJCAC7gtBE+oMDDYhzlZ9pLO7IKShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J5q04TXu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BAmNkyRv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J5q04TXu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BAmNkyRv"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSND2h83934445
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 03:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ITdv+XD97ecvLgG1EQqqXSSAfTzuCTfF007YcPFmgq4=; b=J5q04TXuFzs4id3t
	G+ycMSL7MVxwhcsmAbVkjKnHWGUbfDm6AAEPgkcE9L86I0a21GzDEbbT9rYEuIEp
	4dj/MTJGN0X2/hwtOIsx9b7wxOGoL40lfcjtvkC2AyB57ScvsJyYbYP4rznu/hfZ
	V5ZiBR/GwLv8epuJkr8k3gxZi7IbIcXkkL8C8s7F5Fb3OmGN9opj4E5+aucXoTvC
	N31mG6Zp6wyT921fQVW1NGANkrPDVNysFz3G2T9MAOSzsMVVJjtCAXBet8xy8MQA
	5R8TucuIe5gHz7/aJ1E91QTqHi72kHnru6aBtxX+k3peXRfGootloq6N591RMoap
	eiXOWA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6dr3amc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 03:18:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a344b86f7so319947386d6.0
        for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 19:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766978298; x=1767583098; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ITdv+XD97ecvLgG1EQqqXSSAfTzuCTfF007YcPFmgq4=;
        b=BAmNkyRvS0hNmv9D26LvP6wAE9BPOuZtWQfPhASGukUP5kHpRpF8nWB9benAhsmB1b
         RfatdKda/VHxvTqQ1ZXGamWN9zxynMmYYuUed93TuDUVIun1XxzycryY7//RKW8BgC1B
         4eeN207MDEI6zcFjbGWy+IJDbQ/13sFAUHkaq6DvGygFdYwfUTisDk/zMNXMk04srH2q
         al0rp/j21OLn7oEKVMXnJ2fq1hmUgq8lTl7oIYnb3niDVLgwOOJXbX6Lh0NrMAtirVv3
         LbZjonZUBZBtrjRQgRWohgW3fyWxBuelwuHVmpB954Dcyy9sCk4VjpeNJnoRFEatus/b
         YvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766978298; x=1767583098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITdv+XD97ecvLgG1EQqqXSSAfTzuCTfF007YcPFmgq4=;
        b=lrd6fK3JkQCm9de2hH5XxBAEwqK5xVc8DUef9VbSPGie6lId+FkndXzr7SKSMvcV/A
         qWe9v4Pp4eWWwEB7pc4UyD23OUVSQGrFBlzGy1j3skIOVXw+n0b+oD1vO81iZwQFDYyL
         r0Ovso16wEqt+m/iOFttjeaH/7nsKozhIr0WeJXhi8BZ9nSRb0nQXfQd73gKzY+Em2Xk
         w13blQEpZPInqUScCG2SRhMX2oUFJZYx2PFB6SR6v4rvh7vRayr8ir2biGkm9JS736ot
         Bw2MYWrOkaDNYxqeUh7fxBnlZg0VObCsyMiGQVsjXHYxbP2Wj9NtA3hTq3RMSLHsY1vN
         +sOA==
X-Forwarded-Encrypted: i=1; AJvYcCUKnzm7Bkjr92nbucqAbHGmJViPyw9G0ZCQtIe6bEBCj2Oqr4zNtOXh+lkYNmuIMKkEpuzQoDOIiE79Eec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxUCbw+k0f1OPA7f+gKNBILZ3pgEsqiufON9/oESCf6DnL8b6o
	wOIYLKbsf/17KdxI4YiiiPNx3Xdid9AiLxjYEo56+jgiKhvIgTziIG3WcCUkB9tdl9+hcHLm3AZ
	2brlmCLWyN9nKHwXqCAp6LyYkkt0jTjHW7+7EWWfhqm5Y2x1SxSs6JA+zjnoCxc9QkvA=
X-Gm-Gg: AY/fxX7q+L7Wtd3JD3qg1BelS/pOAsPn0d1fGaB60zYdcVGOx1k6RpRiUInTswmUBcQ
	hxbVLB7fN/Qsf8xlZ9ynwPfykj6TirrhE/3t7WXGJEsG58JbGhLgMOXyslDpy6hbRclGpWddrqB
	Ty4+vXvv9vhLsmsbyfQ2pBbH8GIy5S7Cjeu6Fa8SF6BztsDGSxgbOEOXNcZL96OWTDl6rI6mdwp
	pSUZ9YNNH6a9SaIz6BMfsqZ4keT//k03Y4nwP0KN9y6Yx8fqdIC2V8XL9lLTlq1Z5nxzQAw5LVi
	kWksoC+a8nD8eATwMjgz/kK548PSBAG23gT4uFh6yrehkoUcAzpjN0hqLZpGgDIcgVBY+JWmqPj
	Uc3c/gWXSOQVSu9Jf67W/ixGCfhQm0j9h2ChFAs70ety8RkipRQHNwbhBeSyrkK0Y/ImMOhv5wY
	PXYpwGP0ncg1rw/ej5yS6rfhw=
X-Received: by 2002:a0c:f98c:0:b0:882:3ecd:20eb with SMTP id 6a1803df08f44-88d84f02c06mr321145036d6.25.1766978297651;
        Sun, 28 Dec 2025 19:18:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsx2JCxWudDTojSLtJ9bcVxScTNsLs3QqKsDMkazXxFAFq4q4A8p3Q0cJLScqrGkFVeF0mDA==
X-Received: by 2002:a0c:f98c:0:b0:882:3ecd:20eb with SMTP id 6a1803df08f44-88d84f02c06mr321144886d6.25.1766978297199;
        Sun, 28 Dec 2025 19:18:17 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812264bf90sm74985771fa.35.2025.12.28.19.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 19:18:16 -0800 (PST)
Date: Mon, 29 Dec 2025 05:18:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Restore sysfs fwnode information
Message-ID: <hwykqbo2ktw4slmmb2iodeitd5fqfvzuec5eyvgnttyh3keo3h@cibdr37t4shy>
References: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>
 <CGME20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13@eucas1p1.samsung.com>
 <265b9083-d744-4438-b539-9e001f2138ba@samsung.com>
 <713aa37f-161d-4f08-9417-d7d2abdcdfd9@sirena.org.uk>
 <361ad06d-0478-40f9-9894-6f53d7b27eff@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <361ad06d-0478-40f9-9894-6f53d7b27eff@samsung.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDAyOCBTYWx0ZWRfX4ZKcyQpcW8nZ
 23iLAxAIv3NmrupGqqgQqFrOAeFj7gXTC+0B9OUXL5njrv9l9p/r1N20croGgX/QLOLlAttJFmy
 xFrWo+7gF2vqd6Zo9m/K7WN0HJOqHjszIhdjOn3vftVa3Wk3dJ8b38oRPVewcTABc0hCbJJAzVL
 xeoyLWbrOF1RU85dgjvfsn6o/4N4lo9A7Q9NXNGt5C8LpFQrlFGwIkTvC1q1P6pqNUHyQfceF2P
 /DAVLur5LmLxgWl5xmhkeUadEyLVlIcD59QExNU/89yo7WrIjNQdQPWXqkncX3fsdsJHC8QjFJY
 TyqGPY7wD16Ek1z5SDoQ+BaYtt3Y87rFkOzXZH5iFXbrJE4e9lyLmc8dF+zOmdPKWso35mQ4ec5
 ksYLwZyz2udkhzTHxZAt3OKBsrh5xHBnL6Dur/RmWcWuZpxySIoRmZ9jkdMP2Bj3DWfxS+jn6Tu
 Jk3hQ8XPI57H2+HukUg==
X-Authority-Analysis: v=2.4 cv=VdP6/Vp9 c=1 sm=1 tr=0 ts=6951f2fa cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ZyJuO-foDHcur6j6Um8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: SBqAiKH6HnRsu4Ml4e9reigexqC0rBb4
X-Proofpoint-ORIG-GUID: SBqAiKH6HnRsu4Ml4e9reigexqC0rBb4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_08,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290028

On Mon, Dec 22, 2025 at 11:55:26AM +0100, Marek Szyprowski wrote:
> On 18.12.2025 17:54, Mark Brown wrote:
> > On Thu, Dec 18, 2025 at 04:29:55PM +0100, Marek Szyprowski wrote:
> >> On 27.11.2025 17:36, Andy Shevchenko wrote:
> >>> The change that restores sysfs fwnode information does it only for OF cases.
> >>> Update the fix to cover all possible types of fwnodes.
> >> This patch landed in today's linux-next as commit 24ec03cc5512 ("serial:
> >> core: Restore sysfs fwnode information"). In my tests I found that it
> >> breaks booting of most of my test boards (ARM 32 and 64 bit).
> >> Unfortunately I cannot provide anything useful besides the information
> >> that booting stops and system doesn't reach shell. There is nothing
> >> suspicious in the kernel logs. I suspect a memory trashing. Reverting
> >> $subject on top of linux-next fixes booting.
> > I'm also seeing this in my lab and Arm's lab, there are a few systems
> > that survive but it's a small minority.
> 
> I have a few spare minutes and spent them analyzing this issue.
> 
> This is somehow related to dev->of_node_reused device property and its 
> check in pinctrl_bind_pins() in drivers/base/pinctrl.c.
> 
> The following hack/workaround fixes the observed boot issues:
> 
> diff --git a/drivers/tty/serial/serial_base_bus.c 
> b/drivers/tty/serial/serial_base_bus.c
> index 8e891984cdc0..f3332a5e134c 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -76,6 +76,7 @@ static int serial_base_device_init(struct uart_port *port,
>          dev->release = release;
> 
>          device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
> +       dev->of_node_reused = true;
> 
>          if (!serial_base_initialized) {
>                  dev_dbg(port->dev, "uart_add_one_port() called before 
> arch_initcall()?\n");
> 
> 
> If I then remove the dev->of_node_reused check in pinctrl_bind_pins(), 
> the affected boards don't boot again the same way. I hope this helps 
> fixing this issue.

I can confirm that this patch fixes the breakage on Qualcomm devices.
Please send it as a proper patch (though I'd say, the flag should only
be set only if dev->of_node != NULL).

An alternative is to introduce dev_set_node_from_dev() which mimics both
dev_set_node() and device_set_of_node_from_dev().

Greg, what would be your preference?

> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

-- 
With best wishes
Dmitry
