Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA23290AA
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525095; cv=pass; b=dbQ8X5iMNGzUtbxDAUv4TOEjZxGpOI4IP+5tmlkrsyA6YXGAtrW8YHzKz/V5O2GQSYAwALcHxY62PyrnUKiUBz3xXtFI9Pe9DgSfCESBmWyaMJK46lX+86qDeyLXcMHTuVW7Hjoh32/Zm/H+uAZFAXiYyvnzxH6vQP7UclU8d3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525095; c=relaxed/simple;
	bh=J0DBJDhPyKi4K64Ojy6y17lBqGHCMu6qO5alVMzFIw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJtg4heZKRo7LpWQJpZ4B8jwDmeSQ9PmRFw8mKj/cJZL9ywSU4/5GcTJmfq5lOuQg6ITdJdgRyadMXEVTpRZ1QxJWSAbfIdSlf7U1v3tZPBswmXPl/8wm9gxdRXnjTfZCYhKLzqxjQxgFl9EtnhbZ3dml9EuOcXf2lFKM1wuT1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GLN4Thzw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=grKDoszE; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLN4Thzw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="grKDoszE"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8YPhW3628710
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 08:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=; b=GLN4Thzw5ppeE/wd
	AoM/dI436IbDimGs9DiOG5iPm7qlx7v6S7ZCsWR5VkX6AqY1pmkxpxFieue1OfwE
	uP6toMsp9mFWD4H8oo74JxFN9Uy2fTTcpLx3+PPSNqpAoRyV8on7fVC/V9hGkHEU
	jNl3i7/7rzkLABjCcbrgPjKcje0Byp9mHuIMQ21dnkMxYoMpUj6/sCSoshoJ0mGv
	sEebEGKjtdgAeNtkyZD6m5oYasD9OiE0K57Zn4jMExI5k71q7lRgP8Sfv0tp4RZA
	GkKGzEYPkJUm+7KevEH3JBqjtx7o6eEWMvOhpmg7vQWgQw50tIJngXLdC7yGIGsn
	jqnT/g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049evb65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 08:58:12 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbee8d434b8so229854a12.0
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 01:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786525091; cv=none;
        d=google.com; s=arc-20260327;
        b=bRdpYyMoaA1pOnfM1baFVrRSVfhOJQx7qsb/RcZXEnTbxnEZNOtmkCcjwjfbGr6RCu
         Rqf0uA+y1EoFqUL5BdyIaMx1cMkKxn96/WmbkUukRxLX4zqqq0zlD4zndPidbV5nWD5h
         yt4KpSOxQF2YtrnuwWTZZTHQLr/qSblF4/uF6m4YNfyI2cTOEFlzfFR6RibmZcLKlhbp
         IOBvVqXcKgUckxIeclUugjhSqsuus2rt86L9IIAKkfwe44WF3SyH6/gsxvLEqkuFWC4n
         8GeR4USWc6OifklOc4UJ8PWhlf7v43PLNwjTUiRFm5eohq4BoNyd3UdS7xXfxxquOys/
         aItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        fh=l0Saf6THlgd29TiEWKDh5NUBXWhiAC8p+54nrxV0WwU=;
        b=VlXGyvII0pq/BJSflQvhitIPZCQN9ZT+YyoERBVMOrqvXXNs0hVzU/6ZS4aYaWBvEl
         yK07UwDsnGbZV/iEvCUwdl8jFKILM8hK+IoUsmjb3oG0B/RjUbWGtVAxgEZif8D8E1Pu
         kWid5agruzUVYSXkCUCDQZjKA9pHPK7m/th1ECZCbz8RMzXOsFGmI4+X2N4CZ7GBRhRw
         dF2Phu3r6BkIUMp3pcn5q0PjtGjaH/FChRhGGCmY38LpRzPwmWfySixSVI0UmMmZEKlG
         7Bc//gk/OhwAV5hV2YE2b8I0LiTjnSXinRKCiAGRkRURkaBqIAwmjLAsyWT19BNjMUlR
         5RAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786525091; x=1787129891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        b=grKDoszE4bHmiPL64Y6bp+0dIoBtk18FS4gYbk2RaWfNjKoQgbD5gN7YTKEdfUJSOL
         thFuj6H/U8RRHtEi8X8Pp39QgOo9tilaU3Ejw2VGlOvC+YKU4lMAWtzepYjXupybn620
         b4462p3hpwAZw/KIu8iNAPDX5qZBYARjnvMp4EVp4qrgMX4/ScMr5VtkBNaZYndxMOJq
         +Ur1Eo/EJdUc/Q1NjW6VewWS+iqW3T3sflf6w8MEnziw0h4adAK2q3bfTBCgu5+rwf6Z
         sqRvJYWUNIEF8e/h0D6dQUQJfvbR1A1wSNpP/hI3MJMb+0DzxKcgIQIqAmDi2ZCPRKwd
         tezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786525091; x=1787129891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFA0x3tEHcygP6g65ynR4Scuteb+g36sIUIIXpRnoqc=;
        b=qGLXzmTuASA+KZzNYw7rP3wGVM6THDTwn/RmzXC6m4p9ZYTdikTTPyWxQ+9cMJy8vm
         QOPJI8K+WolGoImoHIRQEcsg3zUlCw5Ljr15AemjHhZUI+7UTVr0LQ57rZMCTL47EaEi
         /VFwDl+inOVU418aLRzk8ZMql+kpxHb1FqKL0A0lR1WIR6G6XhG5oL4Xqux8P+3tekkx
         NALg49gct3J0J1TQCet6tUDgVjCVoalwG14hYT0esK35y+ouATJqXT1J8rC7Y5EOUji5
         skFiuKrh/EPZQdA8qWlob+2Cf9zKaZFsUz+6Vxp8ObMmkDa+0sImfINjf76SKHqqQaqL
         L1LA==
X-Forwarded-Encrypted: i=1; AHgh+Rpv8oCC0HQYePhBEnfyq1t4I9ntJTIcErwZTq+0hlR+Kjekv7MRceU14RyxpDJ3hwSKUdeyRZzv7FKtoS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6Ux5gkZhaNxmRfbVl88K9+VzihJ6sSqhc13T+oOj63hdbH4n
	/TND6mZbegfWFtP1YkWJr8P0xIboi3HkHF/5SZ9EsO827aYCdj+wd3CUlcGZyaNps3PaVEh9OGL
	ZRY4v6cHCt6OMlz0pp+sI+PbJ5zb9ExOlpj/VYVjnFjeivcM8zdr2QIWfm83VPhCsRsawKJt8/G
	rLh1U0MsirUjRGKvM3OznZkClukLR0G/ZhlJLaHFlwAw==
X-Gm-Gg: AR+sD12y+/xhg1Nd0UiZYZRDmUnjNs1syJDs+RQIKDHghdK3LL0vO30CekwvEntuMOS
	1K4HFw2HRmXkOQTtR3qJkQz3EqKxKRHhIfxug3Wjy/GTMRcLXxw+t09QlK68S4yRypcTFG1bGkW
	bMNuqsOjqop4GMeeGqZcKVF2Cre2cQ8SClXfs9D8K5OOeozjdrtN8YuKO0LbjtV7LStz7ly4lb3
	ymGo2saSo7NmO6tTw==
X-Received: by 2002:a05:6a20:3d1c:b0:3c4:1916:9d44 with SMTP id adf61e73a8af0-3cc3f913cbfmr3419259637.16.1786525091115;
        Wed, 12 Aug 2026 01:58:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:3c4:1916:9d44 with SMTP id
 adf61e73a8af0-3cc3f913cbfmr3419211637.16.1786525090708; Wed, 12 Aug 2026
 01:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
 <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
In-Reply-To: <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 10:57:59 +0200
X-Gm-Features: AUfX_myh6JDkLkJD-gnKUbWgAMFmmHbyR3eCYV8kAAVu1iWiCFaF1Y5_s5Z16ro
Message-ID: <CAPx+jO_-1tZfZcjae9shyWcKPsj0fM1SvRzC9_JVOvJr--EeuA@mail.gmail.com>
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state()
 on state 0
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MSBTYWx0ZWRfX0JF5Z1uCEMNZ
 /33xpDyhdhvZ9rWoYOT5kfJKV0VENnwxUVoW9YK3SkcP+iteHn5joMN4BM0f9DKfg6ddYRFEX0i
 hLe66ecm8mMRJDysRwkF0anyS/rVsos=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a7c35a4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=4tH4gHCIEoDemCCG4kIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 6s9NBNLKK4fvkHWjSSQ28MdAKz3Rm3Bq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MSBTYWx0ZWRfXylzucCW68Iig
 CwaWfxgPUwgnbuuBBMa/TAf1G842TxPagIWxyocdUp41i1+9TI0oT5TKz6kH7Z4vVoZmUaW9Nzw
 YSP4WdpmY1POzBxKFBrbV2Xma9gnaEEV+Bg/BHkvUxgMJyihEZNZhLnDyC6AEus0tHsRXC0b+ky
 uw8Dm3NLC4VDjHku+9W43vIDbEdvzC5or2mSVW9oj7IZeSurQF40Sy2qN4935HW0xym+aQjGFw/
 xiI8KbBrx5aotZYfDvJX4rRC1XE466MzWWdX2RVfpSn9A46MRXdxX/nEpp4p4lnRBkpi77PeZaV
 r8oxO2CyuR5rsXG2mGzB4PLbbAA3xRq50hzq4TQr1/LB5eTmuaJOLmSTOvtkqJUw2mZvpwKdsXg
 pFXDujSsawvITMCLIdiGsA6Lkl23IwMfBfEU4LhWWObocYj/Z6iB5wUKLbCPwP9zjJUyrcdjxKt
 djXCzM/uiU0wgI6RUwA==
X-Proofpoint-GUID: 6s9NBNLKK4fvkHWjSSQ28MdAKz3Rm3Bq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120071

On Wed, Aug 12, 2026 at 9:24=E2=80=AFAM Mukesh Savaliya
<mukesh.savaliya@oss.qualcomm.com> wrote:
>
>
>
> On 8/5/2026 1:27 AM, Praveen Talari wrote:
> [...]
>
> > ---
> >   drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain=
/arm/scmi_perf_domain.c
> > index 3693423459c9..e390f902a444 100644
> > --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> > +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> > @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genp=
d, unsigned int state)
> >               return 0;
> >
> >       if (!state)
> > -             return -EINVAL;
> > +             return 0;
>
> Won't this cause an issue to other drivers ? how are they going to take
> action based on changed return value ?

I think it's rather the opposite. With the current returned value
(-EINVAL) the driver doesn't really know what to do. It tried to drop
its vote, but that failed - so what can it do?

Moreover, from genpd point of view, this fixes a real bug as the
aggregation for the performance state becomes incorrect during runtime
suspend/resume.

>
> Remove Acked-by due to this till i give back.
> >
> >       ret =3D pd->perf_ops->level_set(pd->ph, pd->domain_id, state, fal=
se);
> >       if (ret)
> >
>

Kind regards
Uffe
