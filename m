Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852341C5D61;
	Wed,  7 May 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607017; cv=none; b=Ma3sKEqfJaE+RV47yw77ZkeWa5IFDGxtkWrFYL03FDKy/OcyjdCyVAo0XmeL/30Jtsk40iRZKwTQd03w4mC6QZIKetiir+k/3Z5zg5Cxbu8osQizjXYGV9qGELO0DdhVXaDAghLkiWqovXeRhsSIGlB+jzPqOuLFG3nEL8lnCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607017; c=relaxed/simple;
	bh=0zoQF91CKmD9+3ZFkGQ4J/mbC/+3UMg3hWV5M5YNPLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK9K8YrO2dH5bek21LAFb2PWgYkF9+qM3TtwQTY2FwzKSsq3ehXAFeFqK/25g6I7KyrRWRjcMkx33XRQgem7nAe+6eTE0+lVvrjNFsKX6my0pwg4Ez0iA6qQ34fPoFh6b8TX/VV0HYd1cM9Ly07bMoVnykG+dFhMGIzK+2EH/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8808339;
	Wed,  7 May 2025 01:36:44 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5C3B3F5A1;
	Wed,  7 May 2025 01:36:52 -0700 (PDT)
Date: Wed, 7 May 2025 09:36:49 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: serial: Convert arm,mps2-uart to DT schema
Message-ID: <20250507-smiling-scorpion-of-philosophy-7b41fc@sudeepholla>
References: <20250506220012.2545470-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506220012.2545470-1-robh@kernel.org>

On Tue, May 06, 2025 at 05:00:11PM -0500, Rob Herring (Arm) wrote:
> Convert the Arm MPS2 UART binding to DT schema. It is a straight-forward
> conversion.
>

Thanks for doing this. FWIW:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
