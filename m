Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B93CEBA7
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034117; cv=none; b=TVc5e9s0BOH0ZFAo9IpxxhBEo15u34yDKgCfJSVd6yh4xD3ywbBbbjiA44Yh4ycdITq61kX0wueYScHzSVGBYfZGd9AkrlN8JUjkYRwlI5pG+VN1eXe0fqG5CUPDOWTduavm7X8tnOl6Ud04jLs2rY048iayxwNDYGidVljm1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034117; c=relaxed/simple;
	bh=tyS4dM8LDNnjVVaEUlU+wgHkXPDXwJ911Mb1Xht0n/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFBldaqwsQCpI/C709140GEHbFhZYHsWhSARd8AXjWwhjk4DoIfTiZYcfEQ62XMuLBGAZBscOGdcynKnLt1dAheZKkqGaKRAxbSmSBa9AUuZ3MxIXvQx1F4Tjapb1BtlwTffM3DR2cOMfWy9KYYWfIe2ja9ooF7/0WVRYuEFqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NQSqf75W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GZtkjNCG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NQSqf75W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GZtkjNCG"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OC79Ua1823032
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 12:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mS4jEj5hZGL48AN8abxXOvPH
	Yt2uU4n95DP/sU04rQo=; b=NQSqf75WiCRo4qQuvxaVG5Ww5gse30bh8kfLc/Kd
	qFuuCHlxq5tpJCRFxEJnauDt02h08GI8K7TnylqMrtuej82r70N8yBDo+529sPl2
	AXFFJOAwMP3P91M1nafWxcp8Ro1T6MhBqGrEViVulqo6Gf8k0cR3dyZfwF3wHula
	yNPbld1kPWSnNQyiwEt7kHoHSsG3Gr4LRentlmE2qK82ZQMbHLuV9Ioy25bpDlPB
	Px56zS1AOwOnbv07ZTkf7jecNZXZljvUMcxG6BsnPT6TTOrUd3wefs/OFmR+PxRy
	+p4w6xht8aIqkjhhTYaB2ZDNStPHzJ7hZHvqRAQzGkMWHg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqv5ru19t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 12:35:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdd327d970so4825113eec.1
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777034114; x=1777638914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mS4jEj5hZGL48AN8abxXOvPHYt2uU4n95DP/sU04rQo=;
        b=GZtkjNCGbgdaX5IjvGNul/n8kpDWHD2f+xNUdjeTZKBfhHOSa9bdNLYct9tjCkgTgS
         oeCeKSubX4Dr0RaQhB4kcF4UYbohtaWP/88FQxmYtB/YtItQHRu/BlVdOilqzaKCbtsu
         fmgYKVJfByT+KEed4OhQBXawItOzfLGC0mTAAUIMkXnBdQMdS9a/U/dt1jlF5+ma9i2d
         ii/ioesJGS09xehiYSysdYdlO4U+itc6meeaguW8W0/HOrcS1gpouP+6nokkeEazszwL
         ns32FOL0bojQ8vSOw9xSYyNo3/S9KQrrF3K0NAWntRcwGvaqoNpCk5qYN609q6zHhHRh
         17Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777034114; x=1777638914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS4jEj5hZGL48AN8abxXOvPHYt2uU4n95DP/sU04rQo=;
        b=VWlrcEUAgrph4y3yGZ4e+k6+WwkJT848ew036My8ExbYI4wgmIqjafJ4ovuWJceypg
         2Qqz8t9/De/4bdgqUmrrosSKh6AXVu6ekH/6M8fF+12GpnHxa/T1W8DPZsijf6xWnzTX
         X2Ds1ImdXQUkTg9AfQhhLqbnkMCFnmImZd7aVVJzLaqc30U13Et95DQ1f4KLLZaQxgQ6
         1lWYKkDbjJ+jemNjj/iQ25ZtXcCDvQcSWbYSqsWN+Pow6QDblEKi/aF5R9YvtWQ3K536
         3pylee2s4u7gfvP1TtVCI9r/WOTyOigWsL9dCmo0lsbWh2gr5wg6l4figEGZTEKr7nmv
         uScg==
X-Forwarded-Encrypted: i=1; AFNElJ8vBC/tPtasaJERTLYJJe3IakJyjeJuqdW3XNfLXqDfwy6EwowOZPctqaf94ZKS65lL7YuI3pZqlhhKDcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeHnjAAgf5jQjWcKcjU3C5Kyi1Nr5C0+rHcF5TcoI7nMlXZXU
	onvl96xj1c/Dh0c+FAdJ+FCPCjIfiHSNTZaEAxjaxKXr+OGziM17vkEHGo0keTqhDlmqQCeSW+o
	WkLcw3EryQtBJXGnoUcFlcR/bF4u+gY1u6i1dGNPqHWuL0V9XNsHmmcqObl+Fd7D8rW4=
X-Gm-Gg: AeBDieuNq5TUFHV+uCrnzgNQjTaotOMB4vC3DyLARPi9stbvZp7rSHjmdUJudeIVdBC
	o2L4X9C78f2yoCBj/4rYOAleXyZ3HarzfzO87/4PZuCsXfk6LLfFKskw6NV1LCzrbYTZ6x6qs5H
	F+++0XpFGRJJzYUwhK42lypQHnK06bikXzji141rgT9q8pacLP3FREfSvtHFGTh+lV8gDafTA+f
	DlnVxtAXFd2a/rAnZevfw/bFSiWn0YWYUiPndqUVCuFB04hyegT7NnEnR3BroYoM7iF2nNSVkVW
	Yh18SCm/HbDAQx6U7BcJR8ZI1wrcJZSfR8flwuev3b7h21NE2L3bjBZZiBhGL535mhCyf6oVtrI
	HjLfmpOtmFgG9Ru4Am+IARt+2t4oVvJn567FNnQSvjBUadBQPmrPb7pGgsOI6nemaC1rq9ggj5a
	8=
X-Received: by 2002:a05:7300:dc8e:b0:2d9:db50:c6ce with SMTP id 5a478bee46e88-2e42c348309mr12197820eec.3.1777034113891;
        Fri, 24 Apr 2026 05:35:13 -0700 (PDT)
X-Received: by 2002:a05:7300:dc8e:b0:2d9:db50:c6ce with SMTP id 5a478bee46e88-2e42c348309mr12197803eec.3.1777034113302;
        Fri, 24 Apr 2026 05:35:13 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e536e54562sm31403500eec.0.2026.04.24.05.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:35:12 -0700 (PDT)
Date: Fri, 24 Apr 2026 20:35:06 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Add compatible for Qualcomm Nord SoC
Message-ID: <aetjehmqLd_pLtDE@QCOM-aGQu4IUr3Y>
References: <20260420060524.1248432-1-shengchao.guo@oss.qualcomm.com>
 <20260421-spotted-fiery-crab-4defd7@quoll>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-spotted-fiery-crab-4defd7@quoll>
X-Authority-Analysis: v=2.4 cv=LqiiDHdc c=1 sm=1 tr=0 ts=69eb6382 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5KkZDER7cISFanajhDQA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: hYry3ZOJKZuA8dgI11b3EJPqyMufQtDl
X-Proofpoint-GUID: hYry3ZOJKZuA8dgI11b3EJPqyMufQtDl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExNyBTYWx0ZWRfX2VtfOnEoD3BZ
 RrBBmEI8EE1QUTMRpxr9njU2ZY9KKXYF+S0qei4AWTS2vx2G4DKm3vQ+yiN/4uDCXhQoHnpr796
 tV5PGuQ5fU8aSZW34ij1xNW9PUgzglDEVpT4lJh7KZTQ2w9uAfCdzytbJPBycFgb34H1tfCvh1s
 ntDaNA/xj9e8P+F6XeY3pZEiA19hmycZuhAx+ekkZ9NCw07ceApUr7z0fbj0HbKwkDKIMqFPo3H
 nC5tUw0HNIOObwexCLDqZliQvy6EApTfyDN7OkOvDBNPly5z16WvAHemjBEd6qQQifHWcsu73Hl
 9WdOw4nKd6Y+6bQkgbE2WbGudCJg1rJ6nbeVg9U1ETznEwMaj+Q2GzadsWqNTgvPDeSeEp5o7Yd
 le9BqzkNDKPDAOkjAIfSacdpZ5VvmBIDo6djil1keZMwqPs+I2ddKjaM6KQ5uP+HMQnrf6zFx1S
 7F5wf1zi6j5R527JbCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240117

On Tue, Apr 21, 2026 at 12:34:33PM +0200, Krzysztof Kozlowski wrote:
> On Mon, Apr 20, 2026 at 02:05:24PM +0800, Shawn Guo wrote:
> > From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> > 
> > Document compatibles for QUP GENI UART controller on Nord SoC with
> > fallback on SA8255P compatibles.
> > 
> > Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> > ---
> >  .../bindings/serial/qcom,sa8255p-geni-uart.yaml     | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thank you, Krzysztof!

As explained to Rob [1], I would like to send a new version by using
'sa8797p' instead of 'nord-auto' in the compatible strings. I intend
to keep your review tag, but please let me know if you want to withdraw
the tag.

Shawn

[1] https://lore.kernel.org/all/aeowYpvA6MegAX6w@QCOM-aGQu4IUr3Y/
