Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B912149DE8;
	Mon, 21 Apr 2025 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271544; cv=none; b=FsQZ545woxEkY0nAe7LDY3KWZXHQYzDT41JuUnQij0OmgZfvNzkN4StPAZYPBbwqO02OrXzIudXHQ/hxmOUKZXCs7GmOyXoJjC20OubvU8X8wfFDnbU01zFHF4gVqPrS85kW1thkQNQ6FPVn6QJm2JcuEAFrPsGFMbMoLd1J7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271544; c=relaxed/simple;
	bh=P2gkcD2TmU3ybW+EhTsT1VxrzyAL10mA2MoDChIYdbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5dPxyxTb5mjjBPlT/0vtiE5YpXrKGcYnqtMN1Y6fjIvypJKCR6d/8NoeQ6LggvPIiGHv0zO8sQjo7P8CytwppnI90Zw+NogIuYe28aY0pu7wlOdlZ8+d1JiuCkYRMK2RGISoWk87QWD+lX7ie6nGa/SbEuwGsneZpWovftm6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REQsm3pH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REQsm3pH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67671C4CEE4;
	Mon, 21 Apr 2025 21:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271543;
	bh=P2gkcD2TmU3ybW+EhTsT1VxrzyAL10mA2MoDChIYdbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REQsm3pHvLmRf1crBuCTuGBW/4rGeoNYksLlAiB2UaXbWzMNDtlGaYEEZrAqQU1TP
	 dH+/W7fSGorv6qmw7bujZapB6k2W27fFfqZKmgPqphHZ37NGCs0l3SEi2XS3AU7wwK
	 yjuZd+7m7ssJBicv8yrt+FSSbJT7NGkWbo9Ro9PJTzAP/wqDU6GtVt963sda3eAUWK
	 JzXzKu7I0yTUznNKg78zpVUFwaLMuBv9tJJd2LQpztnGgNvHzNXWX53GYfgLwfxPFJ
	 YM1o922lhyYReBdqaWc4Ja5dzVP3DhTncHSNElvKnDncfLBcC1EOdeIVc+j2ZTjfbT
	 EDZ2kANJnZyHg==
Date: Mon, 21 Apr 2025 16:39:01 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, kernel@collabora.com,
	krzk+dt@kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-serial@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: serial: mediatek,uart: Add compatible for
 MT6893
Message-ID: <174527154119.2973427.10851570873227553140.robh@kernel.org>
References: <20250416120241.147925-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416120241.147925-1-angelogioacchino.delregno@collabora.com>


On Wed, 16 Apr 2025 14:02:41 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for the MediaTek Dimensity 1200 (MT6893)
> SoC, which UART IPs are fully compatible with MT6577.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

