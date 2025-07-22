Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10D28983A;
	Tue, 22 Jul 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169372; cv=none; b=W4EJfKDnDiwtIj91FYoNJjPzKaZmB+W5by1+db1ollHmIoIwzkPpFsj+ayCkbdKhJy0CjJ1ucpBbCgT0y/L58Y87gKl8oJzeyt9LezVlo+RhlH/vO70VtPvnuARQSmcIi6FeVRl3XDFJoKQvwnsqRqsWkFFigJZngFwhyitgifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169372; c=relaxed/simple;
	bh=nKkrBEXDkFhE4Q140RSFJyannMs8qaWSKG1ptZYZT5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCaY/Ec6aLqguCg8gc3vZ6nEGjtiWvSbXUlPZ4gcg4LTTnhb0pinyZ6w+xObzDNZcFCjC3IKuNr1tScR6iftc7WcMtH+Kz7ChfVwx7F9yaBwTyhFZez09NROWerxhqVTsjH6lNcMwk0HU8aA35+fakDxSAfejUDRW87GB4vGRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIe0vLl8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIe0vLl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30227C4CEEB;
	Tue, 22 Jul 2025 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753169371;
	bh=nKkrBEXDkFhE4Q140RSFJyannMs8qaWSKG1ptZYZT5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BIe0vLl83wXR3uvsWpa/HiW3iqXMyxFVsJuhJ69sdIASJYxdoSj45sASRJtdL7DyO
	 4tNXqZLXuOCCrb+ftu/Yw+N+spt1BRFYkWBwRkGvE1fV7d7zXTiGTviuBqVYpwK2E8
	 LUsCd2u6vLOJD2SSg94xdFWkmVyhDVsXgamMv49bUirwRs4rUvKXWG/a5P+X6qXX/+
	 laYPxlo33Zog2sH8b6rX2/JGpPCqziAeifg5Q42RXzI0Hul0GmQ/4y90v28vAUtix6
	 QYl0PYwrrWaONSWqqgMQdC5n7jfl1o306yJ6Y4A+n5VXU1csZNCRvcnrkeflhXfGgc
	 iUQuJJVIUPjPQ==
Date: Tue, 22 Jul 2025 09:29:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, 
	Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 07/10] riscv: Add Anlogic SoC famly Kconfig support
Message-ID: <20250722-berserk-octopus-of-destiny-f4475e@kuoka>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
 <20250721-dr1v90-basic-dt-v1-7-5740c5199c47@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721-dr1v90-basic-dt-v1-7-5740c5199c47@pigmoral.tech>

On Mon, Jul 21, 2025 at 11:46:13PM +0800, Junhui Liu wrote:
> The first SoC in the Anlogic series is DR1V90, which contains a RISC-V
> core from Nuclei.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  arch/riscv/Kconfig.socs | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index a9c3d2f6debca1469f4a912b3414711eb709baab..de163cdddcda1c08e7c9e98716eaf043d4c4555a 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -1,5 +1,10 @@
>  menu "SoC selection"
>  
> +config ARCH_ANLOGIC
> +	bool "Anlogic SoCs"
> +	help
> +		This enables support for Anlogic SoC platform hardware.

Wrong indentation. See everything else in this file or just read coding
style.

Best regards,
Krzysztof

