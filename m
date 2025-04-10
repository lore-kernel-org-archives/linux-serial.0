Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D94285407;
	Thu, 10 Apr 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290107; cv=none; b=CB4ed2ebDxo5zqRQd1BRh+0X6XzhkY5jVOB52IkcvVAOZ6Wy8vL3sgR0ldWEl75eTTK3xIj1q5RsdRrUrfIt3t/bb9JGBPAapLpPfWWST+zxlpJp3uTHcuaJVDTcR0cymC/35pWYUchJBbRJmeTpJp08I2zs5pJdeu9IUY3Ks84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290107; c=relaxed/simple;
	bh=gahrwEHFUE7KwYq7sJMl12m80M8qb/fMS46rR8XYUuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/n3JfAQ7QJthgN6dbqn7bglKSZQZU/cSbu8ZQqy9nSERPcuSZ+AhwJZG4jwlgANMmY9VyQr3LbPKcpIsp96e2e8rOp7pQaQGGnNu/SR4QruM98U6MG5yG9ukQz3k+2E6INMn4msYctmC4ABOGwgxYqBOveyzC26Tja36dOO/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1VwCnbd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1VwCnbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D60DC4CEE8;
	Thu, 10 Apr 2025 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744290106;
	bh=gahrwEHFUE7KwYq7sJMl12m80M8qb/fMS46rR8XYUuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1VwCnbdWba5b0gRMCkaDLtg29JX5xXJL6VScl3GFCIopdTCLWHFMIercSwJJ7eb8
	 vT26W5V8tQzQPPaNEPuUSqxVaLzLiIvYl9YgXjkXygf25bagku/HAqcVj10mNHcp6Y
	 eKGmiFEimjW6cHOURVXBQYMOlTevgS/j1Dugllpju2grQzpVLi5Qoar25UZtvkNC5X
	 29Bc090IaeG69PDBNWiGVwQRToCYT8+Ot19Vj0SHHoJ81El8zfNpjtPqCzs/x/+G8u
	 X73QZODZt40STBpDilxGdt92TNbFQsJI7bMyiUovQaDCwwmKW8MbesDO2CLDOirkf9
	 yP9xFk2NyPMww==
Date: Thu, 10 Apr 2025 08:01:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: dlan@gentoo.org, bastien.curutchet@bootlin.com, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com,
	linux-serial@vger.kernel.org, benjamin.larsson@genexis.eu,
	spacemit@lists.linux.dev, conor+dt@kernel.org, jirislaby@kernel.org,
	u.kleine-koenig@baylibre.com, lkundrak@v3.sk,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: 8250: support an optional
 second clock
Message-ID: <174429010339.3601181.9300442715706668225.robh@kernel.org>
References: <20250409192213.1130181-1-elder@riscstar.com>
 <20250409192213.1130181-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409192213.1130181-2-elder@riscstar.com>


On Wed, 09 Apr 2025 14:22:11 -0500, Alex Elder wrote:
> The SpacemiT UART driver requires a bus clock to be enabled in addition
> to the primary function clock.  Add the option to specify two clocks
> for an 8250-compatible UART, named "core" and "bus".  If both are needed,
> require them to be named.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: Require both clocks to be specified with names for SpacemiT
> 
>  .../devicetree/bindings/serial/8250.yaml      | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

