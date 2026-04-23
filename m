Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91237C90D
	for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2026 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942428; cv=none; b=hVR0bykAN1W9Uz3o0fhRGkBoZi6WwzwLJrl9ArqdViObUrxfSBZMJBNJcoXJGtdLZ2E4WF1rhM0tvri6mdBE6AhzwLux6DwKVoEX/uFBbec8HRyzUJQd9LyddzHNAFzN/WmoiFK5Ujr/2zHOc2iOnr128c2Dbp6lq91p3i36br4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942428; c=relaxed/simple;
	bh=9C/kWYxYwf3WG04MyX3l/9Ak/A3bEvzfMk1jFe44vn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usEcxQINUWU4rnkrgZCfH4Bg8FuZDOm1obAP5jfSQDemJpiRv60Gl3G0xrudLqDNskCUJyVO8f/t/qlov9PjklU2pbzCEzDTIqZld++kz0auR7AYL/K6WOsniKK0WcIENbN8GlyHOrfpQ1I9DKlpfgcsIUo7ZoKGJUkpSwTS20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5/tjeRa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BXtT3NQ/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5/tjeRa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BXtT3NQ/"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8trWp028827
	for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2026 11:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AfSMA0QbucQHqV6snfKtLI8N
	WtAMHekaj8A15WhgdBU=; b=k5/tjeRa32ioBD7786omohP/URimuJrH7ixem7Zg
	35icic7FDfemKYXv8Z4aXhzeBFC9o3/zO2uvMwX8D9UHrrqHLtuJ1MJ0jOgiEam9
	jIjs2Cepy3aiC0iNr5rTNE7qtdkWqtPanflBf/C6Ua3a6XjyjxV/cGUj9PG1fTul
	/K8udbo849GrUu6Xk5+Jupcb5AViGG5RJsm3jrlQsORa7rlxiDTBPjdU6RXquIu8
	DtZfXOWnMAd85yKp9Kp5Yn85FSwTzErquzi4W7Nw0IpIo4DwMAtHxi4vyRzPV4bG
	kQv5K/7n3AUR7bPBneoCPa46CpDPgpZTMMWcrc4PPTLdPg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqdjm15jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2026 11:07:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so7906416eec.1
        for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2026 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776942426; x=1777547226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AfSMA0QbucQHqV6snfKtLI8NWtAMHekaj8A15WhgdBU=;
        b=BXtT3NQ/wtJ2IrW2xc8hnJAPY/qHzbDR+L545Ppw0vPuTBIt9RFTZNrmoPqcoSgCFb
         zaKsT6+2iqiVWF07q3PKRrU72NwUxuHbYzQRBlElvZzo6re5X5SLJTYKu7CLm8S3LfRI
         jvwJkCkDbnXK+xRxtiEJqOgDq9PsHoNB7loCiXS4n2zq80j3Bvkb1zfOlV7hxs1DYmdc
         Q1gsI1+pvs4OMbOkin7IlBZ48Qha5ScEE3H3zY+MkIU5W/FAh/oTK0lPqvn88lNc4/Ac
         lmuVpeJJcRp+TSUGY3pI43Xeds+L2b06HI7U4LIsKzq42386lZqKRSIrCa4KhkIWuAS8
         HlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776942426; x=1777547226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfSMA0QbucQHqV6snfKtLI8NWtAMHekaj8A15WhgdBU=;
        b=sYmRLUCNLc1oAE4Gg6gE2+fSMue7OTmLJUpYY153MTzCY5aTMJpZzhmAiaqSbz6Fu+
         6jiF28tL+kxwdHy+y0H++JE3EyaOqQC3kYhHO4FwooZjMmp4VNkXfVRik2pq7WqnjDPH
         37O/idnq1jiUdt7yU4vBTNGCeBBCTe5CgRIKVTKy2CarCMAB3qd06+pgCpKJXucCwEOd
         MjZvqIUt+ygK1EZjwTJsXILb9tFlq9UOlOkT3uS1IY7qa7L8uG8XN24krf5Pn+09r/Wh
         98gz2HBo1feqZTRb3wbCOMgNX2AZXa6reE0iXsR2NDP/lLM7iBXEs93eny6mQ1Q7ClUG
         FE/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+9AaDBH3RpCv1xOfp+Oo7Y7zy9GflglqESMSRLvu/dp7WdK3rn2B59FYIVfSRS5KaHh7IqArZ6pT07Vic=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEkikymBYQW05NO1flK/IesZ5VJ2S4fBhXqR9EJyMaZDywngB
	x8PuZ1bCV3C35rR8+fdQqb4DNTXbfBRSI6LedNPcQi+ooFudfwpRnp/jd0WalFSvROytbaLS8+i
	o5aiDxhhlKD29DMOraeZqj9uEnzLFiyTDQAm5/mM/lJE/FN6XNeigaAaRs7tGN/kEbcQ=
X-Gm-Gg: AeBDietV4w6oNOENUnR1SLBqk4Ptnxar9L+9lk0tvHZLdeLKsfnhcYjONVeK8RoyTDx
	X2mZA2VpR4/dqp7909ntSg6MOvPy3jrGGjfbEBH6oKSJw1t37mREAxITroic0yNbn2fQG9vSR5H
	yMeo9IdH0mEWh8G1yOc762d8PO8mDN5xC3K+lTHTHADKpDKqLgQ4asPIg5/eDtJWe1X4u+5EppB
	wx//k7sMaOpkChluzhzhFGOeQecW9jTrC4MdRf5waj3Q+L3VKQI/VCfaTEYmqrEWtBa9iwkuLcf
	bAnE8nyyqjKfIOzreIrG454YIvhkwjJkllORB7nh8R8dCuWDRHljodSoYpKcNG8YRJiGK7H2EpC
	JIKlTMtIRq2I+ARIjiDxtXkDlfAuwGlQtDUR++tVrKXF64Rwn3efwj2t3LUSACV3eP0X7BIIFU8
	o=
X-Received: by 2002:a05:7022:6606:b0:128:bae0:e044 with SMTP id a92af1059eb24-12c73fc621dmr13828080c88.30.1776942426384;
        Thu, 23 Apr 2026 04:07:06 -0700 (PDT)
X-Received: by 2002:a05:7022:6606:b0:128:bae0:e044 with SMTP id a92af1059eb24-12c73fc621dmr13828039c88.30.1776942425654;
        Thu, 23 Apr 2026 04:07:05 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dbe78e12fsm4439640c88.15.2026.04.23.04.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 04:07:05 -0700 (PDT)
Date: Thu, 23 Apr 2026 19:06:59 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: qcom: geni-se-qup: Add compatible for Nord
 SoC
Message-ID: <aen9U_3jMRagJwgp@QCOM-aGQu4IUr3Y>
References: <20260420064401.1248833-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420064401.1248833-1-shengchao.guo@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=EZn4hvmC c=1 sm=1 tr=0 ts=69e9fd5b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=hCYcIqgGm8RcXDvY5OYA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: S0XsV1_TuoQaaTM8cc9Mv81ZOh27-cv1
X-Proofpoint-ORIG-GUID: S0XsV1_TuoQaaTM8cc9Mv81ZOh27-cv1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDExMCBTYWx0ZWRfX30d98UbcNjWH
 7QwfCU9rqsbl5AWPdm/zwOr6d1FhA2zEoHaloGcig0wGDyD8qXtYevKaoAGJCj7tj0msOThcOb2
 GSiUwChjD2AnPa8TGYglU49hAoQcgMh15yf3vWNtg9MYwv4EHbDAdQLGWovtRObwGcx3uYc7pDK
 inWIaRDlT/uCkmTyxaAHNEpknUuRsuLg9fn8Xe5pqw8WAWEpltaRSp/PuzYwzuhhdyvD9zItC7R
 raRMXKm5u9hZXI6e3YSXmwFS+bgAgdArgG9SLDYE7zc+hyP8bro3PHE1rrs89e8Sy6c45OHzJrR
 wNOfE+oeKzEK9r5u9zqZtqoLpTOWdq92iO/wwZB10+PEOrGqFG7LsahXmJHw0u1K53mQs5PrNoq
 5+ZtL8wetm8+3xmHfDttuQsKwoXE1tFZdbCfks/5kTM035JnQVPQbqIH6+k73LYdiQ7VTlRicEm
 jpYhB59hTsJZMGxdavg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230110

On Mon, Apr 20, 2026 at 02:44:01PM +0800, Shawn Guo wrote:
> From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> 
> Add compatibles for GENI Serial Engine QUP Wrapper Controller on Nord SoC
> with fallback on SA8255P compatibles.
> 
> Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 20 +++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
> index 352af3426d34..d73f9edcbbdb 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
> @@ -19,7 +19,12 @@ description:
>  
>  properties:
>    compatible:
> -    const: qcom,sa8255p-geni-se-qup
> +    oneOf:
> +      - enum:
> +          - qcom,sa8255p-geni-se-qup
> +      - items:
> +          - const: qcom,nord-auto-geni-se-qup

AUTO variant of Nord is SA8797P, so it makes more sense to use
'qcom,sa8797p-geni-se-qup' which is more consistent to
'qcom,sa8255p-geni-se-qup'.  Will update in the next version.

Shawn

> +          - const: qcom,sa8255p-geni-se-qup
>  
>    reg:
>      description: QUP wrapper common register address and length.
> @@ -67,9 +72,16 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        enum:
> -          - qcom,sa8255p-geni-uart
> -          - qcom,sa8255p-geni-debug-uart
> +        oneOf:
> +          - enum:
> +            - qcom,sa8255p-geni-uart
> +            - qcom,sa8255p-geni-debug-uart
> +          - items:
> +            - const: qcom,nord-auto-geni-uart
> +            - const: qcom,sa8255p-geni-uart
> +          - items:
> +            - const: qcom,nord-auto-geni-debug-uart
> +            - const: qcom,sa8255p-geni-debug-uart
>  
>  required:
>    - compatible
> -- 
> 2.43.0
> 
