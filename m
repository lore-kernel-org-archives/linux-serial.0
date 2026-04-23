Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2003BD243
	for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2026 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946108; cv=none; b=Jb/BmkAPuWpxHvUZTCAWIw+OaRb964aKDaZaEPgnfkQMKAtQ8Vdm5O4yQHQveXL6rdMVhJguHA4tMnfgOaIJA00fhbiibKoBJG+UgKvlV9uVmR8UwFd7iaJUcOCFyA/G4URICQdkfdy6ts5A3g78VhgCCiLHb+gMnTm6egIwzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946108; c=relaxed/simple;
	bh=BfONIHy16Ipxg1IXnNR9yugmB457uA3kR5bfe4zDonc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEb1lYjWqjuUSb+g+SjFNy18ZzYW5TnmcbY3FBKFTYW/KLrvEhReJhX3x9bjU9uCJ4+WOZd/LQOh5T7l9pVdefRlXJvQ47HQ/fl86JR0yHGdVR6CLf5PhZx8dpZP67AM5XQNgT9/Rm5aMP5bGRyf8xlTixpedQb/i3aS6juC5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebeN/1N7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebeN/1N7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09D3C2BCF5
	for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2026 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776946108;
	bh=BfONIHy16Ipxg1IXnNR9yugmB457uA3kR5bfe4zDonc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ebeN/1N7ceT4R8As5sBeYi2hTFPtWgc7sh1c5egzwCvdx6+V/Cl8sUDYrvMPLFpqA
	 EKZ/zmXslzcItu/SwnWE+9hQesQh6X/QsbBks1YJ9AWZuqhjCMrtRsdJT/vRmwXkd5
	 zMm4eiX1V9k+5Sb0VH4rMWIKWgUNiglivVaaQLlfrupyq7DoOoshmDluHMn0k4A0ob
	 0Kl8kgkbsP9rxgrfksuQpNBLLNofKEvgDocZ+W8eQCMUe12S+lPZ+wdodsWGSkZC73
	 IT7oA4aug+3lbkfq+sLoR94xP5IIsNXd1Mi6/4G+NHyYpHV2QVAqXWzF7o2HD5TyxN
	 wSiENfVIFsRkQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67845996252so1646097a12.3
        for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2026 05:08:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/gomkqawg/PHXvN7SUfuurncaqhO5lsRm6ympCCy7ajZCSrI1mFF0O1QESq0uUi1v4VXePyFD29oeMGqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJpKFIs+ng4DOviWfZ17AkbutH4mqG7FIyLwOjiEGZFu6xTIq3
	35FPkU2YnGrGPuBZRbGpkfbPhRz8uexMPJ0+DQ6EzC47pMdx9zx2czKrRA/kTS+XeW18ylTaiEs
	YVaIfrsY5JGTbgajQq70PdWHj5KXTjQ==
X-Received: by 2002:a05:6402:234f:b0:676:9caa:f070 with SMTP id
 4fb4d7f45d1cf-6769caaf0ecmr5743709a12.14.1776946106998; Thu, 23 Apr 2026
 05:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420064401.1248833-1-shengchao.guo@oss.qualcomm.com> <aen9U_3jMRagJwgp@QCOM-aGQu4IUr3Y>
In-Reply-To: <aen9U_3jMRagJwgp@QCOM-aGQu4IUr3Y>
From: Rob Herring <robh@kernel.org>
Date: Thu, 23 Apr 2026 07:08:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+2oJF4GG=PDsW1y6Cz7-+Qp2DUz1jXEXxD54PoO9zRRQ@mail.gmail.com>
X-Gm-Features: AQROBzDOEHYMcP_fobtmzNWkOna3yytzRuWeEAsjmBv9P_klDeF0bmBrntE6rjs
Message-ID: <CAL_Jsq+2oJF4GG=PDsW1y6Cz7-+Qp2DUz1jXEXxD54PoO9zRRQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: qcom: geni-se-qup: Add compatible for Nord SoC
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Praveen Talari <quic_ptalari@quicinc.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 6:07=E2=80=AFAM Shawn Guo
<shengchao.guo@oss.qualcomm.com> wrote:
>
> On Mon, Apr 20, 2026 at 02:44:01PM +0800, Shawn Guo wrote:
> > From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> >
> > Add compatibles for GENI Serial Engine QUP Wrapper Controller on Nord S=
oC
> > with fallback on SA8255P compatibles.
> >
> > Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> > ---
> >  .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 20 +++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-ge=
ni-se-qup.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-ge=
ni-se-qup.yaml
> > index 352af3426d34..d73f9edcbbdb 100644
> > --- a/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-q=
up.yaml
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-q=
up.yaml
> > @@ -19,7 +19,12 @@ description:
> >
> >  properties:
> >    compatible:
> > -    const: qcom,sa8255p-geni-se-qup
> > +    oneOf:
> > +      - enum:
> > +          - qcom,sa8255p-geni-se-qup
> > +      - items:
> > +          - const: qcom,nord-auto-geni-se-qup
>
> AUTO variant of Nord is SA8797P, so it makes more sense to use
> 'qcom,sa8797p-geni-se-qup' which is more consistent to
> 'qcom,sa8255p-geni-se-qup'.  Will update in the next version.

I thought QCom moved to these codenames because the chips are the same
with different part#'s by market/application.

Rob
