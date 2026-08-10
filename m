Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751DE3F4DCF
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371577; cv=pass; b=LJ3SbSftoUs53fbOvH4uL5QylcvReXcMdCZGhTIqq9T0pbOwiBXwmQ3ZVxRPFs63F5jkYZJSRVpwiR+Z+rNaR9jDLMsDNaGmbV+jS0NpLuT5FX054aCfrwsR/l62z2an6FRxArwoM0qYjTowPX7utTkmOypPCG+F6YnV0age+1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371577; c=relaxed/simple;
	bh=n+Ksvu/zVWPobgx5KX7GBu9XwArpcsGtQQ3SBCwrIrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKDhc8Kd+31w7jSryB+U6ROiJ+EZwUxTHmgynGyuIMeI0RTqD2mlZuVQoSN3SFjcV/pwOeGgmLIIIUhmtNrTPik2avtvt6UqXQVuK4gL192GsiwO6hxdkjrZPAXynv3t8OYMJujT/9TXgYCxuqpObjnMDrFnrxiTyNj4SCAUBzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ev1TpKH3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UCSWrhxp; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ev1TpKH3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UCSWrhxp"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACjC151367894
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 14:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=; b=Ev1TpKH3ebEU1fy8
	g+4xebhPHPUNEgczi4RSZlAAra5Cj91TiMJid3WIyK5/K42u1qxUcjk7uUCBQHoM
	D8o21YcfVK1/Y97choME6/qa7CdDIhuHrlaVEOIr7xgiuVzpWUQGLsJRHjecc0X8
	5OmdKvdY1UX2SdEE6NQg2yuWzpmvtnJjOYPGFJ+VOPekQ4vxFoORjT1aoxhP7vvV
	YYapTAPpjm+7JFbvSNZqrR5jaeN6QyO+1y8HV8IIM1yy0lsfCMSKDFY5nXQLSOGp
	AE5sKxscyBtkwJygu9QY3Z06kIxGDzYvIbVbErm3jiF7vYdIQvt+b22j8wAU+yxK
	2sR7gA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v49x2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 14:19:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9080b7b2f2bso18990726d6.3
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 07:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786371571; cv=none;
        d=google.com; s=arc-20260327;
        b=feoANO1Hn7ESEhhGUFsHg7caPxplaZMPth4avC7EC931Yr2ko4KUA+wsgT9nciecS6
         f8RRyauot3gtA5zN8E6jKScXyZgjoiBsyKmNPIM3pevmPesBMpKdJwRAucBFn8piKw8L
         HHVFz1vWSdA4cudp5m2zCAJDCotsX90rN/9V+B9Qt6BrzDfRLS7THA0RZBuwOkyJV//l
         8am1l1kQnEBcJaONNXHpxYtx3ogQsSzK9wvdYWHQGkn6/3eu0M0LFXu1L4I5JEvCFktd
         JPyiGLJlxKmQ6CiiCV9lrGVGB3tSSqGk5RIsmc1MhK/ZlZmXadvmV/YBcWaIh42UO0D9
         6cxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        fh=0ZqvpJmo/KXp/rJJS1vIR5t3L0hWCwgF2ZNBLjDjoEQ=;
        b=J0tkhG8zkKu9iakb5Ou/0ZXveF+V2nUBxtZcqIpCkF1cdCPWlKCPHR3rtNdWCZJ6Xt
         qH8l/zZlV9wqI+SHKvGiTf9ygYOPhiSYbfzuTunmWSG5pM01wSgqRTbwD9uEkH5l1yR9
         OBBVxd1nnYWq26SLO7WAbW38HlLxu5oGK/X9haz4JO9JchE1acaum1/ZcF3LmuWRj1gQ
         UuC84oO6u+L2ggMro1jnUPTKGcAjaURka+hXst3+EWOCHmJbYhX+qHMdiIAf2SdlCXGZ
         mt1HV71qsj+z5yNiUHUNSUSjDRkC4aRJk0612uFsmQb5qPRFI6cnr1PTJ85ULtxbC79l
         uVmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786371571; x=1786976371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        b=UCSWrhxp/54c1zxxL6Rv0OqpS43JyRPPHsFf/oQkkHaUQOuChZcrIFqUkWKg3p9f5s
         3n4EjZXaclrirDAZiiexpY/RjB8zKPSQYceo8AasR3z1PQpPvEgeb0fxo/isuIARZGnm
         JhV0uTjMlissRcg6nvjGHn721k/7qrEus1jbl/ZKMYBsYZcn3YkpDdAHKnek8QKgqNDG
         2HlvGa0bplBCE8/Lbm9A8Vhn1apQQQeEqh2E39dnClzQrj/Q/mIPMfcWawvUE4/FK8FV
         wbhn/Gfw8Ko3WABUL6XQI7uUaMwyxTUDlYcCAcvIbaVT3mJuzdGNj2EvffndKF/R+km7
         4bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371571; x=1786976371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        b=n/l5OGluZKEMLe+Y1gTqyK1iTLwQBMepRXekoLaI9jBrS22r8LZAkxMSYDCejws8KN
         2SzRwVvkEZPzNRtdzrrz4H+XQe/7p26oWtygcxMjQJyngqX/x1JkXSJ2Vbe6Po1JQDSU
         415vP2p+tgF14qvmV+knST5HDYRZYiEx2cpKbqUP040doAZh6P4Gfk5E88CXsCOHtMLP
         srdO/wGLmv03KSEvYZFW0kbjAPBNsZk1mXFJXqiRO7Tq24NX/Y8BmufbVmsT8SFd6Z08
         lFgKlVLHn+jlHgJ7ViQX//kGqzUkGVXnMMxwuArN1U0x6dfNT4514sMo+COLGVbzJE1C
         sziQ==
X-Forwarded-Encrypted: i=1; AHgh+RoaHxxCQbPvWDtf+M9p0P0+YcD4j0BmyKR8k727GBv3+kAaQE934EK/ExCJKE/XEV3fnmd8SmLZHr+OU7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpz7yloaCxeF0r4PcQCMr4Nl3Wk45YQnmQPuzYHpaYjvUJKOt
	nQ4FMI0YWps6kB954Kjga+rtbyv27kY6FfQe8rrjczJP+JzSDcCI+6VeJywXfaWQ+Z++ESOBqni
	asZ4w5T1PzPGZAsCnXYnUEWCPyKQaimJSCPqTbG9fVnvToL6Eogw2P1IEkztSVuSHARHyYK54SE
	E0HyHeMnqjgcPIdaruVcQ+bpwEowlGtOcNgvvN13boYA==
X-Gm-Gg: AR+sD103TvJgDdbt52hn+XqVGpkAQjxxidWvbfQ+M/r+Il60U+h8mHdcLMUOa3NKT9F
	Ld9pTk7W9AKqsbSBCMO442o9NUm7PmHa+HOPJJsI2moZAbVOctp6Bb/7gdvJubr8iZkjizZr0C9
	813O5AKArja1f0rhttW9lrmw9j6L7eEr/hawJqB1+aehKShCcq4L40eUJTPg==
X-Received: by 2002:a05:622a:4c8d:b0:521:8ef0:b4e0 with SMTP id d75a77b69052e-52d4bba4201mr24352711cf.17.1786371571036;
        Mon, 10 Aug 2026 07:19:31 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8d:b0:521:8ef0:b4e0 with SMTP id
 d75a77b69052e-52d4bba4201mr24351481cf.17.1786371570441; Mon, 10 Aug 2026
 07:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 16:19:19 +0200
X-Gm-Features: AUfX_mx3R25JFulSxbPIMFamz2pIVHYPn9K-rVq3DlUVa-mxAozC_itBBx8G2xk
Message-ID: <CAPx+jO9MZTsDpofZ0fR7FxJbrfuAV+soqN3x7ttK-F7o6MkYmg@mail.gmail.com>
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state()
 on state 0
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
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: JlN9dhyN2xeJyPS_w_MRZeNLyCtdthz3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXw6tXl8rTuyYJ
 YVmcJAQHi4zdMOwWrKzYaXh5Z/xxMXdjSrBzYeL8Eu5Bh/Y0T/JqCDDnHe2svl2IR/+kMTqrkYK
 zLWc9xLctXuzCb7Q9uy6W2tbuNVPiaE=
X-Authority-Analysis: v=2.4 cv=W5EIkxWk c=1 sm=1 tr=0 ts=6a79ddf3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=IN2mYG8luz48gvOoqwMA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX7ahM7VNHVMAK
 /ZSfOYC05c1i97JAwv+TMT+5qEsXOaBJG++JMbSnpmWfqptzE9YY1M8IQSfICDXV5KnpymiHNiI
 Bl4BKksUD8X+crkuN2ywJ99MR2N1m+u1rFCD3nWH/i2k5DEB/J7eFw8FC2b7dNqfWB7c9daSJHr
 zNyCaRtqysokDUL3V1hTlFBNuFN+ZrkIccMUCFIL4jT/CB+MPlwVMQk0107qhosJFnt1hmtCli0
 xiVXJx/kKxXfDDM4UR5v5qJstyugorIcWrcICSgGSn3Z3S8RVNwng6cxsMoM07xsPnyZYhN/ytL
 gVtlQy27yWsMgBEFzJ4cqVJlerRLoPGfqPwsDSRT21u4pTwH85UZKBzfP96ptrOVmrLNquW6Iir
 B6QWrkReyoawIaC+BDNHZ0GEA2c7bFKXTFkEwP0vMJGWQCt+oNVyChovkHsBpb87OEv0OVj0OaG
 GmPTAkk4g/T48JUbZ0A==
X-Proofpoint-GUID: JlN9dhyN2xeJyPS_w_MRZeNLyCtdthz3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

On Tue, Aug 4, 2026 at 9:58=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.

Yes, this is indeed a problem. I recall that I hesitated when deciding
what was best here, returning an error code or 0.

The reasoning I had for returning -EINVAL, was that I didn't want
genpd to believe that it actually succeeded in setting the performance
state to 0, when in fact it didn't.

However, except for the problem below with the OPP library, it
actually also screws up the internal performance state aggregation in
genpd, potentially leading us to running at higher state than
necessary.

>
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
>
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

I added a fixes+stable tag and applied this for fixes, thanks!

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
