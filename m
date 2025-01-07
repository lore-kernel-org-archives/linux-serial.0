Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564878F36;
	Tue,  7 Jan 2025 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736232484; cv=none; b=ugMq16xDCeWtu4dqqEaMIe8g/Wa/a94sBCawZnybz27UMk76h6YXx7RbwWrybAFRHBT9AkCRkOLlI7r+wUOgs+mB7xnDNtysMjC7j15ppCAyQ1ePsurWGV53gXQwYGKhizNviTuteIGlcOvCO5FiD6DEjeXTWjWy8k6yAIiBhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736232484; c=relaxed/simple;
	bh=WogBa0Uo15bxPipqD5xvalVUQl6VK5qom9xkUazA0kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIeWKMa+wsEPzqHap+QHBil6FG7Er8KIMYcRPU79m1KKfl0kZiHNJMXEb9L1tnEDASx1xsEVxabez3FQJdHmibuouQOVTEz6t5lfVCmbVT0CVnn9GbfY6G43NcXRZ1fowKg2i5A807S5dzsGqjh6GtEmDPKtoB+QJShBRHK3GDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYtq4yTK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYtq4yTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7D2C4CED6;
	Tue,  7 Jan 2025 06:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736232484;
	bh=WogBa0Uo15bxPipqD5xvalVUQl6VK5qom9xkUazA0kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYtq4yTK0YPJAFyf9p8KdCW9I7q9lf/VWtOQxgpJLH7nX0CgEc93SWmpMGN+kZPIe
	 UHvdwRJtoxzDPZ3C2RBXeFQBoMp8UPcz6kSaRyoIKrVzl7RM7mS7rTbsuegZuYRjex
	 U5Ou3lxy7creSgJZlvxig65wcOcqW6O3dQ0yiQ08gALA+o9q10L4rrSgJEOa2R/zZF
	 jw1HmRaJDGxlkVSwFYCzYxbKFWepaejbteaD8z2mp4B5kkVPt26y7h9/P8Zd0Ci2RJ
	 nLIQsiBAiUhEVvuc2kDx+GsQmBAiFcSqByqGGkaKLwmV1sI5ujRPVAwwM01lqPCwkq
	 uZ/vQz7gLvnZA==
Date: Tue, 7 Jan 2025 07:48:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	hvilleneuve@dimonoff.com, andy@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, lech.perczak@camlingroup.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: sc16is7xx: Add description
 for polling mode
Message-ID: <4pcgrt5zwtjxk3qa4twjzvmaxknu7sasmwrgphc364ril7aref@uurm62vwexr3>
References: <20250106085051.50861-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106085051.50861-1-andre.werner@systec-electronic.com>

On Mon, Jan 06, 2025 at 09:50:50AM +0100, Andre Werner wrote:
> Polling mode is enabled if the "interrupts" property is missing.
> Thus, this commit deletes "interrupts" entry from "required" section
> and adds a description for the fallback to polling mode at the
> "interrupts" entry.

Can the device actually operate with interrupt line disconnected? I
skimmed through datasheet and they did not mention that as a valid
setup.

Best regards,
Krzysztof

