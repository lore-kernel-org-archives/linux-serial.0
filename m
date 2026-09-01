Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306538D415
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274377; cv=none; b=nD2Vm6fvWFDJUBI8EGtVLZ5wQU4pG2Og5rbxKduq4OI76YjxEAaS/TYFwXowHjp11BK6YLqLzhDAe58OvBlO+c6ZC9zB7GSuiTSYbZy/EFgYuh3p1hXLiTYLDU6f8ozKV4kHvOdYcn3VCzk4hS0/uOw0WH6LnSXaLk/8Oe6JxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274377; c=relaxed/simple;
	bh=FgutlMLWuX2PARBJ/ZNazI7k/MjjaVYPSOow8B15yCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL32OK2/DDwIxfCRLjQGgK7yPOuWkUAOBFUrt93hp+3sGtb8BnQTLO8GXszZhPm0LCwVdXnIyfw7qcWyru42yFP8ypto6vLyycdQ7HnnVDstmI8Gz+Iye2YfB+W/xXa/fjHnsogJGzOiEtXp+2NBV0NmEpp5hSGT321rfN2A3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fv5D50Gi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BAN3qurq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fv5D50Gi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BAN3qurq"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E98YF3257802
	for <linux-serial@vger.kernel.org>; Tue, 1 Sep 2026 14:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u00WPPm2TIE3D1kE+ENfOWwH
	aQh53p3wPv2JgUWu22k=; b=Fv5D50Gi/UA8VcdWQ5Qla4lhjgQMtRAUkPQyvuE3
	H4p8KsVEJioA8Fcyx0nwYufUZRU3XoMZ0HbYQOKDBhr0kfwoTfjVFkuFOIQP7sQo
	Ly3NSJGv669P/47uyMZGYlu+N9TyHebzvqfOaGFRb3U8ldYujjuw7yTPwn64jJBG
	mgS/zUBDQDPsjpMMDDYbYfsf3d5Z/P6eyQn+QmMylSA6vfFVOSUQEVEWp5EFJV94
	xspE5yWPpeRqFSWbLIZV4M7Rala8Krlj8/wcPD6FwPPQoMaw2JjYQmTRznWjN1zw
	IF5h1VDu31L+CHUbNCHOAKUgSXbkdAFmYHKFyxSMIqwaTg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdynt0d66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 14:52:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93918756165so1109744785a.0
        for <linux-serial@vger.kernel.org>; Tue, 01 Sep 2026 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788274375; x=1788879175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u00WPPm2TIE3D1kE+ENfOWwHaQh53p3wPv2JgUWu22k=;
        b=BAN3qurqskuD4uROnF+TopEH1qQQR0wUHNWUZH4tk7yYDYVeZnRD3TNhF08lSjIJaj
         Rp3vDjE6H/Ug8dINY2f/t5b5R+5oCcyDnr6PFxNlRACZBLOE9+1Q6oi+lC2yINoTiOu4
         ZN6DyCSEAUbcL1jtHAGBLLS7/ZE8RPRMIM4Be/FNcwAYBAoJMyN9BYwrypp/Wl0lRQ9s
         6nc5nxGcXe3CLuqUZC/73yG1EZvPvu2Wvt2W9TnEIjcvnmD6L3ZU38BCbaTL2J7LeH2y
         7UuZrT4hbsX6jjrO03ij/lzy/gcKDjtLWZFg+BUMJfg8ACfCy7fv7e+ZOThVzrs+ccMK
         pNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274375; x=1788879175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u00WPPm2TIE3D1kE+ENfOWwHaQh53p3wPv2JgUWu22k=;
        b=bYxtg0dC5cnFPbdqTfVKj3qb9EeRsATQAlHs4PNdc3qERvucXMzcpe7pFZliATEHXO
         UwciqUQtDWQnh5fxJegNA90TcU5GY6KKFjO3RHxhUxAjaBS2mg83wtxbKuqj99Na9712
         IbofGuiHRieDu7G5usV86JXbZIYmGNqnsKFGLnosQT3rG35fyYE4wJuYKsuppEaBWgbW
         hlFPxu+5la2irmXMaNYzBTj6X7CJ/ll+FwADZ7q/QFhU81uqaoyFeBa2Vqa1PniCEVQn
         M4KEYDly04T+v/1Re37WTa04E0yqqJgGQ2dMjmzo5AZryqhWcq2fM/JIbwVs26uDQvnU
         gOEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtI9ajHpyplLUWBLthuGpJof136q97hzPe+AID2z6fH23oC3KfUM5pO07oUauBh+y6VhB4rh8DHsdHYHo=@vger.kernel.org
X-Gm-Message-State: AFuF++kcqNawbmQk2V3cZ7SqNs+6lQhSmgSo2Y0AVkpfG32FBfKulO5P
	C+Bz2Q3pVV98lrWwIY/3QfOYmYdpBF7kYmbXNpePISsboAhsQRUgAgEBP7Zh4vojdx5Mz+K6PDI
	FgWlUtlCi4Op/F6P8AbyC1h8QO0TfAqPTf3DDF15fHVOKQ6WQa2yYJGgDs2ucY5B2bFI=
X-Gm-Gg: AR+sD10+mi797ziUmNvH3DklKirvXlunf7huj1IfaBomXPykLeTjSTuLLql0egj910t
	KUEYOP1fMS4S2ITIhmI/soHN7ObR0n0PAJqEJG8BmC7O15zu/+6NyJWuNRbVtbS7ZGusfJrWvAt
	iNdlkTQd+s51mvt8AX8ayHUQT8tAuGgNH+Ec4UTxOewZQTDBRiEb48iQwrc/XfuHKP1jV08OZR8
	19OsctrVabE/hEewSVi58CRHH13c6xXP7AfhJnHdyfOkUU3lNtEIXAvUQDHgNCJkbHljeJsk60E
	5Pv3J0eMpQ1cB14eVmk3WGh4zD6Io77zS49DwT6QkPgnO3iLdY++SgSPax0FTviAahh+uFH96vb
	CsEBH3n3sjUi/7g==
X-Received: by 2002:a05:620a:a183:20b0:938:8ddb:5e9b with SMTP id af79cd13be357-93947f81d7fmr956280585a.8.1788274370650;
        Tue, 01 Sep 2026 07:52:50 -0700 (PDT)
X-Received: by 2002:a05:620a:a183:20b0:938:8ddb:5e9b with SMTP id af79cd13be357-93947f81d7fmr956267385a.8.1788274369738;
        Tue, 01 Sep 2026 07:52:49 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c52fdbsm273345915e9.0.2026.09.01.07.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:52:48 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:52:47 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Aniket Randive <aniket.randive@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        naresh.maramaina@oss.qualcomm.com, praveen.talari@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1] serial: qcom-geni: Avoid double-free of PM domain list
Message-ID: <zcpnlgkc4x3uizna37cysfhgr5ybs5adb6hdqzuuirndkd2tmg@wxsacjjgq64q>
References: <20260901-probe_cleanup_uart-v1-1-0bc2b00c970e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-probe_cleanup_uart-v1-1-0bc2b00c970e@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzMiBTYWx0ZWRfXxIxIlTlmhVQ9
 omg11OudvrBmQC/pwJNjxc+b7nLwPegeDUgk4b1msR3ubW1ETTjWUvx7s73o0l4i5Dspf1dABSl
 rDSgiYeRyGSh7RJENtP4mSxMcoNOV5c9DAJ7mL2vGRxiEI/OBX0J94RDYO4XgTafhc1EztA7a/o
 vIBxUsGFSTm1CyxZ0rj57DnPAefEl+js+M1K5Eft6nKBvfMKhclFxAvJEJGWVU/D/7HgCmVu3ZS
 jM5+DTISOX0ACt/MIgxPnhAF2xdpt6as5LPvd5iHPRI1kBL8pBbmEjpplYtCnKd96Xheu5WdhSo
 C5wo1Gg91zHGCkxBY2gHHTJIv3ckAbzXJfV5pgY6p0rOjql2nvvhHMZF1MgOOARhWroAbDWYlWu
 V7ut8Ys5GsdkzdbFjV8RUUqGx7pvZbqM5IZqhSCpigZWMKg0WVmT+P4SjZ5HmcZwxwMM4BHGR7A
 14ok6sHBV9jtTpAod2Q==
X-Proofpoint-ORIG-GUID: 7fyfjjHX62bKmF2L66sXywFbUrqclzJf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzMiBTYWx0ZWRfX1uqi6JFY1Bk/
 vQH8p2iVgSqyy3sKlqs9nr+8+ifL03dgJCyALouTVxTnIyTCnFJJBektybK8C3kViTzcKIKc5Fh
 gdt812YNyFrGMCRAwQkbVkuHNtYglrA=
X-Authority-Analysis: v=2.4 cv=LfkMLDfi c=1 sm=1 tr=0 ts=6a96e6c7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=G5ilVN+faPP2Ze1SHB4iFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=5Qeq7Wt-fVvOjBGoxIkA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 7fyfjjHX62bKmF2L66sXywFbUrqclzJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010132

On 26-09-01 15:20:54, Aniket Randive wrote:
> The SA8255P UART variants attach PM domains through
> devm_pm_domain_attach_list(), which registers a devres cleanup action
> to detach and free the PM domain list automatically on probe failure
> or device removal.
> 
> Remove the manual dev_pm_domain_detach_list() calls from the probe
> error path and remove callback. These calls can operate on memory
> that has already been freed by the devres-managed cleanup, resulting
> in a potential double-free. Also remove the unused pm_domain.h header.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
