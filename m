Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E626248896
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786331662; cv=none; b=L6S2iyMmy+2y6F3cHC99YXHOBPlLRrB8nQ1pqeH8zN0Hkjj/ImcCcc1lSpXAIJdMPikeGysRcgAt1Ms96rC80zg6fVHpxefghLj07+rwFCn8Qh6DsNA4aP8CZC4fLjA1KEV9LDo/F6owETZL4xRuw5OzI/rpKPM/NtxGGDHa86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786331662; c=relaxed/simple;
	bh=hJVZGjdzMszsM5bjwrmT88RtUDhCOhiCTzcuewL63EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBV6aPeV+ZFBGK/DtZZE3bp4SiCe3y23Pxec+/w/3EWY8yvkiTe/tlQu9jX+is99srvNrPy4SK3ezWFCUwwP10OncqaD6I3706ePgGSPKX6M2su+Vt4ms79u96J2tb7kHBaPkPddv7zK1Qk+DRZWgLLlIlsBad7VSDmXqqOTw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PCjKCX5O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YXSUJvB/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PCjKCX5O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YXSUJvB/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679MuXRd3696411
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 03:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c20YFg7R+aIz/hgdPzYueBJ9BwfxuVTOpY3oG8UMOr0=; b=PCjKCX5Ofd+7t3oH
	jGFoKUF1nRrglUXU2SIReN7qrYQ2HncGc+x/56ijyhXfXyjosTfaopA13lvnBFuz
	QSLuwioIX7ZQuYffzZ00RcWHsu3ykXYxz5T/Zj6u7UcmPPbANFV57YUz3vqryp7o
	e/egEF6jIhNZFEQ90cE3Av1v6gaEu6T7Ee3xZfPuly/xRuxLqBAHbDtIC9406HqA
	sObhoyFKPKGqsyo3OxOhgPJgoi9Gh+cRj4aNWFWEQEbReqBw8EXCpmIkWT28/gNj
	SDQRAJg6DDBUH4EMkYWsPamzAI9j5r66VcA1tdswOZXpZ1W000R80/jMf9S3YyFW
	H/w1oA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fww7cv3n0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 03:14:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bfe3fa93bso12787511cf.2
        for <linux-serial@vger.kernel.org>; Sun, 09 Aug 2026 20:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786331655; x=1786936455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c20YFg7R+aIz/hgdPzYueBJ9BwfxuVTOpY3oG8UMOr0=;
        b=YXSUJvB/LR639BRMr16COatmxzLXQOvVp9KA+Ss09ZbvcrKjEAEvuud+wGCy0f6tsz
         uFlCeDHLKuWF7xrC37B4UOxc6uwU9a9oHohGbvkxHQxcWsLVGx5B9TGlNAHS7iOF5EO0
         SEv6khmT+nOEPE5TOzRjLtQr8oNbAIJQFLlMaEp6q6il8qITc8IxFikpBh452GmGk2JR
         bFOnbKk4PUCuBRO94gNtJij2nmG4XLEeVdIsRrcdO7ThgsKGoApcX34ZeChQTbwtOiXk
         9ld/kC3MGEyJPZplvtx04fhQiUBasg168+s/qvH8lcU9vF64PUQCvS0qn1G6AQKFgi+b
         gAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786331655; x=1786936455;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c20YFg7R+aIz/hgdPzYueBJ9BwfxuVTOpY3oG8UMOr0=;
        b=cXXARLxWjSOP2j69hMg2wLyexBIOvDKTPZ7ZqvwSVfTJFiIFKFO8f9o3B74FD6lnCz
         m4Hyu/q3QpyOermwbAIiemM+JMhCb5U6szJEj2kuwhUVuyqG1VCcs4F6SjsOqTfxJCgZ
         +PtmgXCp+316PC0wVuE2MrhJSV2Zq6aNJl7pPVMA58PoS4wUk8SIuBIYxjlHxrXjVpWU
         7UWK5+NQTiY5po2FTqzFNJTYG+g4+b2eWHD24kqDiKzDS0fkepG7qyjHsoKrybQzTHM4
         BHa/2YwBZ2+0/0eFLnJqYytiv5nxOJSqVUP4Y3jukDJmgnXlfUda2vT1Sp/hUZrPfpux
         HFKw==
X-Forwarded-Encrypted: i=1; AHgh+RreGkqsbZ93d1WM6rUExIszVMDDbDsn0WYmQSFwDRNi/K1fAwV7iOHGcelK5ehBgTLzCWnb5raaQXDdVtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMgTiJakzPmaKdBHA9EF3VgxQSmX9nMMuQT2seU1GEjSq+lqS
	MHNr/wcJ02bl2sVGaB2dnyC8laFBrdGMrISg1GTnKoVTDPVGDUYkYHgmUMOLT6AjFxbuglM81gA
	UsmPJFxxgSzb0t+mc8dCkPfLPBW4Dfmx/SFXD7bBuTFAsVgbZaMwhWD38R7lR8NtJAsw=
X-Gm-Gg: AR+sD12NBGUEL00dU+S6un+PMFv+QsSEz0LmiFJyhYtw2GVNUiEAHB8I+Z10BWzOM3e
	EuXfDawQd13poCjUUp5vnhD+x7tVEU/0cDjg11QMWQJhjGkbbfdepCQZ4n92OvxuBlXnz32kY0L
	vgxBytduSQR/D1sg0AZae+6alKw39kybd5Y41BswCO76K3dN2ssInkYFniKnTPO5o1/4ZhwfqXQ
	Q1+8A+/azCX1w2sgTHPpzvTCd30Io4s/S3k7wWTfQR8kZ93YyaqZKMVT9q/Fbc/Ny3ci9nZgBZ+
	6RhL5gQVyzbV/SOK46pSbTv511g9kAMm+tKez87rAwrlOt/kl3EnqO3pj1vxX1ofB+/1ZYtkrgv
	ak+EjoDbvQah8Zf7eVmGS95c1SkwAjKb3Yfs=
X-Received: by 2002:ac8:58ce:0:b0:528:162e:29d3 with SMTP id d75a77b69052e-52ce614ba88mr400898781cf.32.1786331654630;
        Sun, 09 Aug 2026 20:14:14 -0700 (PDT)
X-Received: by 2002:ac8:58ce:0:b0:528:162e:29d3 with SMTP id d75a77b69052e-52ce614ba88mr400898361cf.32.1786331654128;
        Sun, 09 Aug 2026 20:14:14 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021501bcsm29134102f8f.9.2026.08.09.20.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 20:14:13 -0700 (PDT)
Message-ID: <f1067d27-6b39-433f-b1e2-ad753e54153d@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 05:14:12 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] serial: sb1250-duart: Fix bootconsole handover
 lockup
Content-Language: en-US
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2608060322360.55540@angie.orcam.me.uk>
 <alpine.DEB.2.21.2608060359330.55540@angie.orcam.me.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <alpine.DEB.2.21.2608060359330.55540@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WK98Xf5xf7OrAJJmgfzFpsT75qnmLxS7
X-Proofpoint-ORIG-GUID: WK98Xf5xf7OrAJJmgfzFpsT75qnmLxS7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyNCBTYWx0ZWRfX3u1efkJ4yUpl
 HEOkLXHSvqkRSJLnKus6sLwD/IJ9YZROg+K7r2fHlHwbRCHakqHvoatHlEUQcp82AUksBPy9ZcX
 Sa1EicraDwj91tw8yA6ocNtOgL51PDxGnQdfjujqSGKiuR7nEsJ5kxciEzuV4lo2lds9Y8yVOSh
 bZjObdifxNSw8PBfSbpEoSUs+pJo+XUqrxO6g7FHXDkd4Sr2IH2SL+yuqfG5NVaqX2pJD4wiVLT
 vqVqkHMY5c9N2x+Qj8Txdnb46L4l2TEzJxw3b1tnBfk6INem83yVIGpZzJIHVX2jnY6IAXcX3Gk
 +fRQvmSxuiPNf27BfBaBy7U0w6ERDt4eq6pSojN/7uBDh9JZwufOnVYux11VwcqmuDsHd6P3Qqj
 6cik+qirDeV3VXXHcqB9Jtg0O0O5X0eKOzGrDY0zff00kMlS+U/oxTorLSHMuj85SUeMmIf6hJ2
 w3T4XhSKVQs2tHKwGQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyNCBTYWx0ZWRfX300ZLSC+fuHd
 nlMjeWsgmHmJ1+vtMzcOvXgTWgBL5TaoQzq+pdsM+3hrAQc/zHNA+lZEXUldh8ac67NOdLPcqUF
 6I8hMS9EMPJatJih1f8Jl5xZsreKTzA=
X-Authority-Analysis: v=2.4 cv=IPsyzAvG c=1 sm=1 tr=0 ts=6a79420c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8 a=_xeo5rayHQ2-IrAwGUsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100024

On 6/8/26 12:54, Maciej W. Rozycki wrote:
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
> No change from v2 (2/3),
> <https://lore.kernel.org/r/alpine.DEB.2.21.2605241623110.1450@angie.orcam.me.uk/>.
> 
> Changes from v1 (2/4),
> <https://lore.kernel.org/r/alpine.DEB.2.21.2604130338210.29980@angie.orcam.me.uk/>:
> 
> - Sanitise the change heading.
> ---
>   drivers/tty/serial/sb1250-duart.c |    7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> linux-serial-sb1250-duart-prom-console.diff
> Index: linux-macro/drivers/tty/serial/sb1250-duart.c
> ===================================================================
> --- linux-macro.orig/drivers/tty/serial/sb1250-duart.c
> +++ linux-macro/drivers/tty/serial/sb1250-duart.c
> @@ -542,14 +542,19 @@ static void sbd_init_port(struct sbd_por
>   	/* There is no DUART reset feature, so just set some sane defaults.  */
>   	write_sbdchn(sport, R_DUART_CMD, V_DUART_MISC_CMD_RESET_TX);
>   	write_sbdchn(sport, R_DUART_CMD, V_DUART_MISC_CMD_RESET_RX);
> -	write_sbdchn(sport, R_DUART_MODE_REG_1, V_DUART_BITS_PER_CHAR_8);
> +	write_sbdchn(sport, R_DUART_MODE_REG_1,
> +		     V_DUART_PARITY_MODE_NONE | V_DUART_BITS_PER_CHAR_8);
>   	write_sbdchn(sport, R_DUART_MODE_REG_2, 0);
> +	write_sbdchn(sport, R_DUART_CLK_SEL, V_DUART_BAUD_RATE(115200));
>   	write_sbdchn(sport, R_DUART_FULL_CTL,
>   		     V_DUART_INT_TIME(0) | V_DUART_SIG_FULL(15));
>   	write_sbdchn(sport, R_DUART_OPCR_X, 0);
>   	write_sbdchn(sport, R_DUART_AUXCTL_X, 0);
>   	write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2), 0);
>   
> +	/* Re-enable transmission for the initial PROM-based console.  */
> +	write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_EN);
> +
>   	sport->initialised = 1;
>   }
>   
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
