Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6D1DDA15;
	Tue, 13 May 2025 03:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106935; cv=none; b=ZV+t52Op4/9VGuif2UTzmwvOX7WKVlu/riak7ExNd6ajJGEQHGox3EtGgqQD+pfQ2Y1JwdEORiC/wfA+1DNJwi08sMjJx4TNmuaHd5GmV4NyFrEO5Gz0nQ69mWwUHOL6dhZW5nZCxNWwbprs+nTJyggpmg+cnoAUEombEAu4V7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106935; c=relaxed/simple;
	bh=nlidAinZYUT322HwR8/oE2mCs0i+XFKD7d3jlFvwtfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sb2s2O0q7JyaSiDP8P93ZvsGTAPG3y+XBlfCmAAvI6d9wZBBC5xAUXthcF2MLZA54hAwmzYv5Alrbh4lKQWNIItv4cHukxfoxozHiV1yHfoCV2j1FoNtvFXhUbAyonnk34aHTZ7LMbU8KOdU+dVjxwhsCBTN7K+wmoIThuWHSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY2+9r4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY2+9r4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F377C4CEE7;
	Tue, 13 May 2025 03:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747106935;
	bh=nlidAinZYUT322HwR8/oE2mCs0i+XFKD7d3jlFvwtfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NY2+9r4w6czBuPExnI8VRVoSc9uod5OW+cTfj83RD1jdq1fZFxsbtyfaIjk5rRIhg
	 UicqoECQ96ANgLviGoJ1mqoq7Q5SeymDYh4V1LZnrf7y6t4ammPZVRnDOXERxo+JPE
	 tG4vNH/8QJWFA7bqqF1kuOIjxXA/dtwRWMNftB4kv+aNpsNqe82OpSXSSlWpoB50nm
	 BSnK+rrWZkT+8usFNedWDsQVKPS++BBnTuOtB+iBv6iSdNh6THGsx8bAeaiacPqv2n
	 xuJcnPppSV+nFaA2TbQ5FX+V140PVK/1VAVtISJ3xD+iRSTrAYJffqOQOWVeWhCN1W
	 Ix5Xn45QO7/gA==
Message-ID: <1b90e435-868a-4bc5-b9c2-096e06451449@kernel.org>
Date: Mon, 12 May 2025 22:28:53 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: Convert altr,juart-1.0 to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250506215959.2544931-1-robh@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250506215959.2544931-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 16:59, Rob Herring (Arm) wrote:
> Convert the Altera JTAG UART binding to DT schema. The "ALTR,juart-1.0"
> compatible has long been deprecated, so drop it.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   .../bindings/serial/altera_jtaguart.txt       |  5 -----
>   .../bindings/serial/altr,juart-1.0.yaml       | 19 +++++++++++++++++++
>   2 files changed, 19 insertions(+), 5 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/serial/altera_jtaguart.txt
>   create mode 100644 Documentation/devicetree/bindings/serial/altr,juart-1.0.yaml
> 

Applied!

Thanks,
Dinh

