Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC93ABD8D
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273108; cv=pass; b=Ef2ufygM2zNmgeMLhG+KtNgawO1OMnqPOBKhjKWafFGTVVuJ3/4MjuGVcjmIpnJuwwlE/46o4HqJ6z0PhoHhJU+/9uLfAatRcG5m8HPeAkmmFzzjcnO+NckNfQO7XY5zmJmjrNbP5+j+9H9z+GGPnPkK4H7BGI9UphzK7QBgY40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273108; c=relaxed/simple;
	bh=CL+Fm//7PJAuTWNWRctOu0wP9tKrbcMfws3PNuylb8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfc3bzTneFTaauyWQOyNMIj1gfAmDkowUoqJt2wmFHSdkrZgmb42jOWnMBN761QmZHBShM4bSX19kf8oiVwvr36ppAVrFaZyYBgMBb8IlMGx9OE+CqozceXDGCe+ueoSRuT5f+O3pdJRZKlvdKL+ScDlcBruwvszm9971CgdNEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TWKV/Sbg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MHUJpS+J; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TWKV/Sbg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MHUJpS+J"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E95qv2217552
	for <linux-serial@vger.kernel.org>; Tue, 1 Sep 2026 14:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=; b=TWKV/SbgV9p0gmBq
	Ix/czCMtVc6C+fPEUJMX/wN5rmWOaY2sWrV8k3FCPsPVdBHPZds82x79UGxpCqCp
	/pVpjTMlX8ruOOfAB4pzE0il1Minieoe88KD9Sw4VJi1bgOh+zoS/6IfzDz5g8KM
	J4padN2WR4QivG/XXxD+bL//mbXyEPOzB4v81QzF5er6+cvoinwDYAqvjPEBlKjb
	fjX5HcnJIoAASFUUS/1g6Hq2e6QJhqKeo3LNE8Ut9OkR3ueWUadOU0OQD4ljSMCK
	j2mGoFWfUxYrnESW4/FvIxt6z6yf87rCmLVgMvOg92INvotvppxD5od8KkAFNDZv
	mmzjXw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdndxb2db-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 14:31:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e4ef486c7so1123786b3a.1
        for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 07:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788273104; cv=none;
        d=google.com; s=arc-20260327;
        b=ACgVlICL1XjU/0JaoNj575VX7fe2yNo9EMlcU0ZQ4ajLy3s3/8o36XI6OChQVhIy+i
         MPN7qhuG7GXMitSDtlY/FGpQfwjWCdMcE279kFUQhENmYtA9NjiHUfgkE1/oUISAZ5oB
         CmmALP3ThH0LL6CZAj0scmXabd0LMlX3C057AwXV4gKzWtIKw5h1fG50et0J/efCXmVm
         MVPDMe4AsSL0lsMui4K55n0jUEAX7JmMZLhN01E/gtG5SY5S4UFlo9PUo/LiCF8d0uKt
         wa/a6Lhm93p0ClCkggSrsfpzfPeifVNGQQEl6Mw/mewnCuqHltZy3vOAL7NvQCtfE6nq
         5+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        fh=/xIOTH39WPsUkSjJwHdmmxzMtfo3wIMFnaEBkyP7z4M=;
        b=km3GgZzRsxH0bNgRQBVi1/MQXc/2tqMR8fgZrsYh8xUyLk5Zq7z9PSVeOibkHrAnDs
         cFNjcbmUlE2uQLp0/Lu/LBPrnueYDCWoqHAZeCktpbLX8b6Mkk6YyCc2HLxk3tZdqPqp
         jfsCTov15WnFOzJB5urBl/2GCKmKpqMQJwZTy5zW3EtSChb6tyKn5hWW/IEDnhCNf3oW
         tzIXmvWGFKvihS9BR8P/kPOXEmIUJAGOQo7aI4sNaIkdAnXkgZrW44A/iRpqv9SV/OGX
         nw6XyGik7xSg3QgPzE4iv1qXfvaduBnw0kIwMu9JbgTJDFrlVq92vnbGyKGjlUh/0tQw
         4/bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788273104; x=1788877904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        b=MHUJpS+JNG++WoSWrEusvWGQMqlLb+1WmCAkp+miG6kasuPoeE49mS8n7EzTVE2WUl
         s95CVfOFKfNjrElcCawac1ADbMDyc8E32+S0feYuZoYFvsar7b1F4KT8ixYVsoGrEzSh
         6VHSl0jYgm+3WW8E9FjvQFb2czYam8VpCI3nQLMCkz5xAqEgDHkFpfuIQph89MTzBSC5
         E/cfUPjZuZkHiZUfZdXQrFo9OD56US+ILdg8evX8Enajd9ij5XyZLZM/Bs91xmFiG62B
         UJANEaiKgCk3ahQGG3i6rxwj5D+ewO0pdoTwlIGI+54ea5lCe/vO+BTCaZeyBW+Lo2Do
         FSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273104; x=1788877904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        b=gqMV0UXcIgO2lyxiIj6E6sSPCZPZsz02RekZPFMqpo3nHKzDvNLpbQ8dU0zTZxac7v
         poDqMklyw8FWICwfJuIzG2I4pgBnKeqhdQUtSR+ildTfvMYsKOYbZU0BBb844zJq/uo9
         mxGISodZxv2c1SYiKwzvJ6hF6BAzvvrJ5dQS8FvjHhEeupLunjtkR5L41WD1JiLoeDJg
         730gt+sNMjH+W3aogddvEXR14VBuChAEtgUSEOdXj3wLnVi2JA6E+UXj7ekYUP9aR120
         tkkF8H0vRykWVHYjxRStCe3MwRCvkguB1hnJbt4K8Vcg1/wVo6Yp7gJCMi4OD2BvaJIs
         HzDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdhuQTL3vXXdq2PLg/eo7UqD2sAgzJLbVEXGu/f+ydyaYKwLjF7l7IDUhTWPw81RMREtQxoFs8g5EIwus=@vger.kernel.org
X-Gm-Message-State: AFuF++neq2AYd/YzOdAXww5YQ1UwnRJ1mQfcZaLOZd+gbtcq8J0sqQ4b
	KZx1sfmBWIpVAI8s7IjhRBoQ8Gp3P0Ns05J/x8OQ5pk8GTKJf9tLdTEQMNjY9g032NV9LzCtvEU
	9qXDDe5ywOOb4qJDLe7rifIK7xxHHTO9vpDVzvMl12B5Uu4xzvBqoEsqYsGGtpfrTGkjAr2KRtp
	hx2LRlS+Nxa3SasuTsCnyVKZlgoAdZw19+5RYWfUjUag==
X-Gm-Gg: AR+sD12J1K751sw627/yKrvRlJi8WfFmmDH8hTiE668uVkoG+KXxmcXAoL2xifNOEcN
	8QgAZpo38dlyJ1plxlqER4jt+iDcOeKI1DtnA6zPhEv3QTEbHLkNruJRuKngN9lD8HQdmUSlWKb
	De/XlIE7isLpXBJdQsma2igU6M6Z4wmq4P3o3LYxWmF8lNlQNyUCwOYfc0Wg==
X-Received: by 2002:a05:6a00:420f:b0:854:b3d3:8631 with SMTP id d2e1a72fcca58-85bcacec88dmr5179005b3a.12.1788273104261;
        Tue, 01 Sep 2026 07:31:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:420f:b0:854:b3d3:8631 with SMTP id
 d2e1a72fcca58-85bcacec88dmr5178917b3a.12.1788273103642; Tue, 01 Sep 2026
 07:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 16:31:32 +0200
X-Gm-Features: AcwNN1WwQtMTDpu5tktdI1Fc85e8Ltr3tWd5G78kHHK2UXE66ekj0IR3sGBbeCc
Message-ID: <CAPx+jO8HQj4PtBScf-w+nQz-9xe+7QxZLMtp=J=sFSwEHVLL_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ZxTmPwekPJlG-q-zeyT6l-RvJahE05Vz
X-Proofpoint-ORIG-GUID: ZxTmPwekPJlG-q-zeyT6l-RvJahE05Vz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfX6/KYlK0m54m0
 GlG8SRO7NIMFmgav4Ttz5MuJfkXRGcmymfrUvDo+/P1DZC/uHKqt0bsKglAQd9PqpSOkJsmL9sB
 pOL7bHcPTQOc/5dvrr57OepP+8CI4sA=
X-Authority-Analysis: v=2.4 cv=U8eiy+ru c=1 sm=1 tr=0 ts=6a96e1d1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=iiyz0f3IVUh47B4zfGIA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfXzzN4IhB82CoU
 sqaCuOp2WMcykYLqJ+KSjkmsD3OGJ0Ot0DRogcgunL3oUH4Yulj9EKjIN7ddcE6eVImFPGU24xX
 nYUgZBYDb4nLxgo7oQf8FJfLP71CZN4dE8fQF3jjNn2M38iSy5F3IZ+Z3Vsle9Lb+lAwep0ZbO8
 4gI2P6qeD5hxhqxHz+CRIB2gtRIqQDctVCNZdHi+TLlZ5kl8N4XFwHOpiBW/wffTagKtZ/81XQS
 Y1jsJm556zETveOmu1fgzDvuaXSIfez2BeziWlVFvZABSAR/vZlvcfYp6E806uA++FvKOU9wFTt
 uq4tc56OgXtUJsl17lJ86hd+o1q0r5vsrtE5c0FpAROkMnHzCcQDk8NQDIe2U0v6AovKsRrwVaf
 x1xlBCO22UU4pCyJ2A19xV/Y0m5iGR/tClpR1eXslx9m3/URKk2o0UHP2Bf2loRB5LXxcJ5OCUh
 UEvtYN+XpG7D8a94nFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010129

On Thu, Aug 27, 2026 at 7:59=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.
>
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
>
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

This is already in v7.2. Please rebase your series.

Kind regards
Uffe

> ---
>  drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/a=
rm/scmi_perf_domain.c
> index 3693423459c9..e390f902a444 100644
> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd,=
 unsigned int state)
>                 return 0;
>
>         if (!state)
> -               return -EINVAL;
> +               return 0;
>
>         ret =3D pd->perf_ops->level_set(pd->ph, pd->domain_id, state, fal=
se);
>         if (ret)
>
> --
> 2.34.1
>
