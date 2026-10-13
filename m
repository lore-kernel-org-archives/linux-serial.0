Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4D4FDA77;
	Tue, 13 Oct 2026 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897526; cv=none; b=dEXoZl92pqzVc4MYvy96rf2x1kLM+fTsOGuZmjr4+A3JPXJdYGbYUeFQAD+I6ja6VJQ1lDfUs67RMxmQD+eUXjd9BWdqXRXcmXRHCMZ60M1slJ9gQfKKZ0X4RVP6I896QKKDEfcwFn5HoNllRCVIM4wNY8Gpd2EllB9xT3xcHgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897526; c=relaxed/simple;
	bh=GZv+56/nA2PI3ESk+a74I0vEah5kjoavPN9w6GQLbTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/N/MARocXXcwRv58zkI2Dv/23RAkpGGQHqfFz1BAF/ozcVhTwcM+054wCbVCs90YxnAmGUCPJlkshAjbzXYgverfSabVg4Zp5idgRsFuTgbmm6JRO+otQgKxfmc5n4ZpvJi99hEqLpslcPJv73sANtb/wT6HzW1FII9zZSLbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dlH9JjoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dlH9JjoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1881F00898;
	Tue, 13 Oct 2026 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791897524;
	bh=2r8QOTmMMZZU94RlkFkrv3Vj5oIB5c5yukGEw0nrS68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dlH9JjoH+QwyPshhbwFq2PFbTNtTS2JXWHR5StHRFVqo6B2K9Kx9MAXnFrjqqJi4X
	 R8XPZp7DC5bg9U8FVz9iRvIFq46CeD/PnZf2kD+y/i/4dDk4XneBgMSuatxkVE5nlU
	 zoznLXQ+GV2mnZ2nPT8DhZ2dOpkYGF/3T/OTpZbo=
Date: Tue, 13 Oct 2026 15:18:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: snps-dw-apb-uart: Add Synaptics
 sl2610 uart
Message-ID: <2026101342-uncut-identical-c701@gregkh>
References: <20261005151918.25259-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005151918.25259-1-jszhang@kernel.org>

On Mon, Oct 05, 2026 at 11:19:18PM +0800, Jisheng Zhang wrote:
> Add the compatible for the UARTs of the Synaptics SL2610, which are
> compatible with the Synopsys DesignWare APB UART.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> 
> since v1:
>  - use sl2610 instead of sl261x
>  - send as a separate patch
> 
>  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Does not apply to the tty-testing branch :(
