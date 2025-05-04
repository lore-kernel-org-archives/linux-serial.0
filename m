Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486E84A29;
	Sun,  4 May 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746378600; cv=none; b=WH8rg5eDW/H9P/vSpf0Y40ajkx5LD7FNz0hljboTYiFYvGhrKhPNteptZX28cMXEdSVcGq7wwMJkBA7cSgOx9iqqv3rYHLMR6dVOPiF2tmmxkcuae0drwjngSyHcPzckUBhCq7JFSw20GhQUsw4cDaqCnPXUOm0QGFZDC3upWjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746378600; c=relaxed/simple;
	bh=DHKSJfYJCd2InIFKt/Zme3Y3SRdPHc9bFn5oLj6g3ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIBa7DQXyYwOdlAbr/DQ72VuLiLTxPP11Dt2livxljKrERf25QXY/YI8q4KtPQqzjocGGraQDvSI5yAd6f1L7XU+Y8jt1PwNwHj03et2B4HIwOBtGfvnaP/75UZoh6CSHnDKmF2n93SE3EZTze+Nc1D/Ahza1uZU9XpFH9vqmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYZzFAxN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYZzFAxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE7C4CEE7;
	Sun,  4 May 2025 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746378599;
	bh=DHKSJfYJCd2InIFKt/Zme3Y3SRdPHc9bFn5oLj6g3ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYZzFAxNlY3wdWERCzMQw7F8AFStTNSXlKm3x+TMb3zMBZ+r+YhGXUU16qe08dvCv
	 C26tAojukA8oyBsbRm1S/kNKVBDl0b6EhEpzBxMggPUjnk3IF33WjTpe7NA1dM3zm6
	 sWC6esDxj7xer9oF+YmDr6fcNqqsxKSNOJYWeqE4oV2pp6NIJQaF7HRyVm9T9Tvv+k
	 oAyEibE/UPNuporRVmOTH+aUR27MuuE0e+83rTcLIEcssj7OZp769J1D5BOSVV6eBh
	 VwFNnIXr8DqOctiZZmVf6MRiu6Y5HBhYG2d0upX1myyVOk/h9vlCoT7RRRbdZhUcSi
	 UkEuz12P0Znfw==
Date: Sun, 4 May 2025 19:09:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com, 
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com, quic_arandive@quicinc.com, 
	quic_mnaresh@quicinc.com, quic_shazhuss@quicinc.com, Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: qcom: geni-se: describe SA8255p
Message-ID: <20250504-funky-coati-of-vigor-fe1fe5@kuoka>
References: <20250502171417.28856-1-quic_ptalari@quicinc.com>
 <20250502171417.28856-3-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250502171417.28856-3-quic_ptalari@quicinc.com>

On Fri, May 02, 2025 at 10:44:11PM GMT, Praveen Talari wrote:
> From: Nikunj Kela <quic_nkela@quicinc.com>
> 
> SA8255p platform abstracts resources such as clocks, interconnect
> configuration in Firmware.
> 
> Add DT bindings for the QUP Wrapper on sa8255p platform.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

