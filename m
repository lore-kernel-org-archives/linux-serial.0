Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE829BDB6
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177298; cv=none; b=uUcgxnqIybvNA0a0hme38T1DpK6IQvlyL1lopVVo+mu4ty5tkE8B5FnvkdfCp7T5kg3SeXQaWanhHFrfhufZZhyCFZTq39WeLibOUJoau47wQSwaHu1MGXCarfGgYflcYojTkAaZRb5KBiUsU+VzbkAJXG+htnCThRFMVsk+v6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177298; c=relaxed/simple;
	bh=+0vSdZmOwq8F/9R/kI0phGtqmphJwJ5lflmVHUCDqVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjzspJ/7mclENujvFyZVQzcYkNb1j//4M5yDXn96e3T0GRUjODaBTprp/G/WJ20KlMBzXGemx+8IORZBAYRJGuGMKRgIWTJ0h/Enild8+UV2Wnc/r4w1uDkBdiZDmviPmjB4yZHWkUYODdsi+mpQ7WX+4Ckl4xAruXKZG/PG/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AdRlBb9B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AdRlBb9B"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6Q1FQ030267
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 06:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LJ+vHFzBs1wUhjHtKO42xRexrj+VJ9lROsx9KC1ozbQ=; b=AdRlBb9BSGouk+ms
	L2026v4vGXrH1CFsu+CRBdl0yTJfQLwpXnopG/j1TbCnmNx9FoZawSH+J6cE4WZk
	jjoZYjkYCRVWdzAmikYXDrpYNUrIRjsNWz78Cet2XOCpoEQ6xkMD6uF6760MhiGe
	eAtxIUwGNmg7z2BGflHcY0bHfDVntUpHJcK3gjkDbciuta1hqoK1wRIJSSjXJp1+
	anZewHoIa2YXlOk4oqPyo0vcrwm8dWGDcrTjJuOdVbXxbY/Y9X5aitKXqr+OQQW6
	gOSrS3VQFmPazpgzHAhP/JIYcBIXAIwsB07Qd1LKLac8xKq5ihOaDXfEkGsJWu4D
	BuEr9w==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jb5yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 06:34:55 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-732d6d922f6so3555077b3.3
        for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 23:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758177294; x=1758782094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ+vHFzBs1wUhjHtKO42xRexrj+VJ9lROsx9KC1ozbQ=;
        b=mOlsKkU+xZExaduiOSIk+SIIweY8v1Unf7jlvQ0hy+zcIurKNV0EuOMyEvgeCIUpTu
         UW5xMmNJh5L2vhb20IwEAJ9vGRJUrf840uY8y/uzf6O9Ni+4b3ltSCDSnq/ZNcfVa3j8
         5h3eoZB6dwJ6JBPyWEH46V2PBQ/+1MX4/3ZNVe5Lk6ik4u+5w/kKErJ3zGa1ttn1u4FS
         O6LDJHYBQISFHOnnY+znY9c7jxJXY09/05EsziqFUyIE3sWnQlSDsPnmSK6g3KM0YxOx
         Pe2CNGjk7uYFod6LSWmMWc4+f97eb7zohOf4gHcaTomHznXsoLOFxYPSu409Go+i3lNm
         b6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCW1dVUIPD4KYI6korsAWMPxtA8I7D5BayD1dymj2v0U+pSWPxM8NyNBI3h/44OnkTqZqW42qlWkD+d1sSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGzgr8OrwvHaBbIzEQTVeE4sM5pjLcJ/3NGxgH+ZeoS39ZhIM
	hemIBOn4HX4cQqSjzuh26qlIxvIYShyjIVLGhv1g7X6fbQVO6fNvwO95prdwO4XSwm/2hU3dnjY
	OBUqtksb5KwI7I8emEE9eeoDKcbpqc50drXvdOdJ+hvWhzw0506BmYjSqjTozSLCaqzPfLL73k1
	sV9bFdlsH/KgagYvy4zj0CSwsdkHVhM0EaTcdj9jQsIw==
X-Gm-Gg: ASbGncsDmEcZk03RdKeGFXj9sK2kvdL4rwXXt83k6v/2c7pDZX6wy8KPbPE5kxo4ayt
	LFelrTaKPmEgxPmvfG5qjFU7S52njSJmVF7M4Hj+nNz2/cMcY/b9P2b90fjyWFWe6CgHko0Nj7h
	SgYHNx7rW4M1zv2wr5D3DywEE=
X-Received: by 2002:a05:690c:87:b0:723:be18:e6de with SMTP id 00721157ae682-73891b87043mr37498837b3.29.1758177294179;
        Wed, 17 Sep 2025 23:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF359T+ynH7B0YBVHYdIUSznowf26uiydfg4Xsq82Eyh2GFZoEJFfVFBb/Vop9pNIb3aRomnhYSHj8mNK6v8TE=
X-Received: by 2002:a05:690c:87:b0:723:be18:e6de with SMTP id
 00721157ae682-73891b87043mr37498627b3.29.1758177293634; Wed, 17 Sep 2025
 23:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916093957.4058328-1-anup.kulkarni@oss.qualcomm.com> <2025091701-glamorous-financial-b649@gregkh>
In-Reply-To: <2025091701-glamorous-financial-b649@gregkh>
From: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:04:42 +0530
X-Gm-Features: AS18NWCwmtfeqFQcg9i-B4xEmvRecUhlo2PrXpNtE39W8_lbS3jp3t7HmtTXQys
Message-ID: <CAP0YdSqCD8MZPrj0ekDHG4LhoGm4s3qs_z0xubD5hQ=vBOv9_g@mail.gmail.com>
Subject: Re: [PATCH v1] tty: serial: qcom_geni_serial: Fix error handling for
 RS485 mode
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, johan+linaro@kernel.org, dianders@chromium.org,
        quic_ptalari@quicinc.com, bryan.odonoghue@linaro.org,
        quic_zongjian@quicinc.com, quic_jseerapu@quicinc.com,
        quic_vdadhani@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: XyQxJnSaQJpk3PZ-RwtUaMLXTic-t_21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX8qEDnp8wZ4Fr
 coq4YPnsuZLfv6mM/2zNmDk9KLZ5l1HOpba1Mn9p3cBATtCIhfPDtgGb6iMMBAQWVGuzZ1GNyqt
 GCwvYhUqlVeLqemDc732iO1QCCXM9IMlDdiENrwuHHnbmfmizkURuNrUsnwaw+amcFfAqTQIXvL
 V4u883SZyRDEYPK3UNjVBmTy4m+aoeQswtjm4gM0jKnRFoZa/u5xiQkWNXnkbJu1N7KAlpb8F4U
 mrgMsKkREzhsD+IAqh5dJqcN08lG/wtD2xGoR7nDhFPu+3QLWlck4ueBInClQ7hicLHfIGGvonS
 yfTl5+Qn4Y+V42V2sOZpBQaZJFWyy7SrzqFTd620A+EirwC+NWeWB2GBMHJIzjBdExDjAsiBDT3
 IGycwtA8
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cba80f cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8 a=EUspDBNiAAAA:8
 a=oPvcWFQ82zTIPni4Ta8A:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: XyQxJnSaQJpk3PZ-RwtUaMLXTic-t_21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

On Wed, Sep 17, 2025 at 4:45=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Sep 16, 2025 at 03:09:57PM +0530, Anup Kulkarni wrote:
> > If uart_get_rs485() fails, the driver returns without detaching
> > the PM domain list.
> >
> > Fix the error handling path in uart_get_rs485_mode() to ensure the
> > PM domain list is detached before exiting.
> >
> > Fixes: 86fa39dd6fb7 ("serial: qcom-geni: Enable Serial on SA8255p Qualc=
omm platforms")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I've taken
> https://lore.kernel.org/r/20250917010437.129912-2-krzysztof.kozlowski@lin=
aro.org
> instead, so this shouldn't be needed anymore.
>
Agree. It's not required now.
> thanks,
>
> greg k-h

thanks,

Anup
