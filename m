Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DD301474
	for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776759447; cv=none; b=qEsSCHMkOhKsRWCoyTPunzIIikPl/nJbEp/S3gOicjrjvP05UsdBDX67aI9+HAkE357TIVZ9EroA2pZOpyrekKArOYqyrrFy4+uALlfG2Ky0tLuln4puGZ5Wc0PeVAXNy0Rw9Bjz2da57h5Mhe1iHU1Qmy+2dzLZUCkhtDcl8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776759447; c=relaxed/simple;
	bh=B+IlyedEhZNODOK1mSnA/Zegncl/8PN6pid22WrPik0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbltjjPQ70M3aoyFCRNeFixWl0E0Yr2BjUCzHrVAgpyXgFQiMsFZ1tkemYRDJ26hJst6S4j1wK5OTYhKRJ+nexxWMUOMGV4bQ+yDSIEaZ75Ls+bk2mrrpPCYzW0TFZVeB1qrpWJuhwfR+YKfVcNGYFT6gVqDcdRWlKQ2RgZffNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gecQMdlp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GSk4Nqaj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gecQMdlp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GSk4Nqaj"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L8ECJZ2281651
	for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 08:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pW4RvJ1J0WjZeebgyc1hyYHI
	FUKi/UttC0Wl6Mb4bxo=; b=gecQMdlpFY0k7uTpdGCoOknDM23BJE4rmHMxiFKO
	+iIjg9/Rn31epo6HUwOr/GlNEJCZ3Bh1SA+VULyJaNyNy950ff+YSwZnvZVowz54
	JbNzY6Ynw70e7MXSBLgxLxnm77dAe0Psiw25NQfyfzhCrEJaHP/F3qa8ke8MK/BY
	vxmTCs4d2lHMvPVnnoFRpt/gr62VkOIwc56S5ZO6xY0pyjwTxmYJiCTXgVtXGcL0
	MupbnYJD+g2aUoeO4he5HXv9PU9pTIVYufekgRyH81uNwaV5v52RAO/UDdd2K4qV
	ijXdCGI20rpTAs7x949sB9tvi8PMKuxi1PQ0h+1Tk0kUQA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh59cj34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 08:17:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c16233ee11so5349114eec.1
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776759443; x=1777364243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pW4RvJ1J0WjZeebgyc1hyYHIFUKi/UttC0Wl6Mb4bxo=;
        b=GSk4Nqaj4+h89mpf7T4jAbQl2wPLCBAgym4iJEazj2piFPRhN1QfBpjfOJygJT5sBJ
         jqO5Fo6IxIF0ZyC0Z3/9HrdKKve3M0WjMgA0fwLbYpu3mT5A7jc0n2UxV7LPrm2c7DAn
         EOnQ1Ni233Ph1b1ogJF7YRX56PS/rJ35Q2VSc9mTIMnKZc0cPCysQ1Z0SGxgpt6hiseF
         jjLZHniwLvBIEIpI9Apaq3WvVSihzrVKnfqgo2WezRjNPP9EN/6XsL6QR/nl5wNbvBM4
         YWt8/ITj0JS2vekHp0+551QiU/0hzHonka2aDmLJ9AxK2jwRiFUxZZmK5oNuL07tJBCv
         nmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776759443; x=1777364243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW4RvJ1J0WjZeebgyc1hyYHIFUKi/UttC0Wl6Mb4bxo=;
        b=ju6rUH+VKPJEuOdkK/sHxO4cecrErxQajK8ERN457KZfU0Wdf8ViACKxCm3Qvz3s09
         PGxziqbpaN/yp5KizYnP+z9JIZr1KFMMb5RcQLOODqnbfuWgg6A74EBiohwjhfhWwI9C
         x+kn60AtYyQ7us70+nPc0odELirfEyBG+bucR2fOMiOi4vfJBqt/9dnQnOCRLLnPi2F3
         A10FGWEKsKG2YfUcaDWS3oCVqQk2kiPVUJteMzo4fQ/yFT1r9RfdBbsWyCJgn5JcY5Yy
         Xy35dTUVrYMBppIxrFYCn9XBA8KqKRqIF86Uui5wuDOSQD3tvUbTLkCZBRhiFWMKOnPl
         JxrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/ieaVxvZkwliy+c5aYq4HhYYImcTpzKm8a3U9HR+hc4FC1UDutIiVFChA097/h08BmlIpvtXW2tQxlJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70EKpLWUDM/L7fT3/ZYr+1ghH1SAoZJE2cfmhTRC7dvxBNlvL
	g17qOLtjQpwkZQEZHAG3DZ7VWiVCnNI8gaOv4wWH9CqCwhMwT8iiA/jfX6ogoqllhHFtjQk7CD5
	VYkujjzz+zTkaWeJvLCWIM/OUL99m0BbLvvQ9Dok0MqGLthlGMp2oxkwpJro9OWnamQM=
X-Gm-Gg: AeBDiev8/lc8aeygOfhEKudNLDUx64YgElyGczYih2FPBew033/FKwgdHWznpcjPorg
	rWz4RilxvbN6VCgoy1Xe2FmI5coImlm8l7D2DmJP0dvntf/jFavf7tTMXorxbKUpQc+3/rjuMOV
	RFuued+0xwXEW/LHLfH8ZZ1hAhg+IKemPLuipwSEUPAYuKyMnI9vS8DLEgiWFLP4Y2Oe7mZ5Cmb
	emBKaeAK7m2DoWaRrOy0CSgVSUAmbDOfPleRXxoWvtS/SqqhBOcI+kZ1gTpudhM+F1MYlnvFl1N
	4lFk/USj/G7fs104dyj/EnE7+YoAAlXvV/vTQz0ggZ/ETd8Tlp4p6Loe+l2i1DGSxd6VOa6uENm
	0tHb4tjjqSdV4kxl78VKAz8jv5AtmWatkokbz0oHgsJcf3DKGWH3MGzPNRhfr9UGB8PI39IfJS5
	k=
X-Received: by 2002:a05:693c:3007:b0:2d9:6373:ad0a with SMTP id 5a478bee46e88-2e46538fd04mr8455843eec.11.1776759443506;
        Tue, 21 Apr 2026 01:17:23 -0700 (PDT)
X-Received: by 2002:a05:693c:3007:b0:2d9:6373:ad0a with SMTP id 5a478bee46e88-2e46538fd04mr8455826eec.11.1776759442926;
        Tue, 21 Apr 2026 01:17:22 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c38sm17625182eec.5.2026.04.21.01.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:17:22 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:17:16 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org,
        Praveen Talari <quic_ptalari@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: qcom: geni-se-qup: Add compatible for Nord
 SoC
Message-ID: <aecyjAkRes7hC1_G@QCOM-aGQu4IUr3Y>
References: <20260420064401.1248833-1-shengchao.guo@oss.qualcomm.com>
 <177667402766.1199205.7736172019278854390.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177667402766.1199205.7736172019278854390.robh@kernel.org>
X-Proofpoint-ORIG-GUID: JgTjmFsGSH44KaW0RXCj04rP3FjPHKsg
X-Proofpoint-GUID: JgTjmFsGSH44KaW0RXCj04rP3FjPHKsg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA3OSBTYWx0ZWRfX+KgduuOkz+FI
 b9HZIQGfvcME3hSaFSyTD9Jy8XO1P0ZjFs3tOB8WITvfxrwB/+ZwTZ3A0/UqZuCXTC1lZJx6hR2
 0QdcZOhABwO59eaUMsRto8bWKVWp0OQJ3ErsL+Sxan+TrOUft7RvDmRicS6ED8UpMI6SQL4QlzK
 UVuRHkbLI2BcD7tjkxaNt2hyP0nWAlV3cEoXr0Lc+vX8Wb4cpaHLkAbvWld9eLyK6PLfS+FBzsz
 r06ZEKbLtVUb1tMC5ZnKGNh0YegwO2yMQiX/5zq+ge0WVgw8Zh6kcPBu2+iegmyQ1JEptD77e7M
 Y5atXMLvBnaqf0gYQGICio7a8x2p9TkpYhgirA1PASkOWTrVmPbCMi97YgKdmPJbjAUkhzBwUK0
 TmvO9BNuAMKUC3nsIHTKumSrcLHDsCaHn4PF0KQ0CRglqpETjHuLd2illLeGgh5bE7sNZ184EQ1
 ayhgdYHHI4d7ZSoyZqg==
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=69e73294 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SdGosrV6Qt3YffhYJa8A:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210079

On Mon, Apr 20, 2026 at 03:33:47AM -0500, Rob Herring (Arm) wrote:
> 
> On Mon, 20 Apr 2026 14:44:01 +0800, Shawn Guo wrote:
> > From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> > 
> > Add compatibles for GENI Serial Engine QUP Wrapper Controller on Nord SoC
> > with fallback on SA8255P compatibles.
> > 
> > Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> > ---
> >  .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 20 +++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml:77:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
> ./Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml:80:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
> ./Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml:83:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

Will get them fixed.

> dtschema/dtc warnings/errors:
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260420064401.1248833-1-shengchao.guo@oss.qualcomm.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade

I wonder why my dt_binding_check doesn't report the warnings, as I have
yamllint installed and dt-schema upgraded.

Shawn
