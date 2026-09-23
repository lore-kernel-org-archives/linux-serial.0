Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131475172D5;
	Wed, 23 Sep 2026 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165294; cv=none; b=FEyk9Ub8kqcdXDLELraQSJlm8+WgFv+MdcjE/Iv8nbqbEACY0fU4bKbRQ9BifVSW3R8gaTx3AuxBuAdRPbdKOPLY4CsjJqvw7m9isOabn7disIHjF32UrRUA9uKoVWNDnHvwjJOnHhYuTxS0iz4A9X6KnAVoz3Lc6XMvoWtn9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165294; c=relaxed/simple;
	bh=cyO5yn//ziFYFdLxShAJghimKuMhAdXaxMLBzYa4Yoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jylfXwuHwSBPXJ45STZa2w5ag3WoVh09ynZXtXXQfXzrEQAZs/b6YNNL35BJ0S95kJK7HsQgbZGSTX0A6HnuX88aFqu1VTxWfh5EWB9tInmaHeGUZ3j+NIWdWJ6KGHd27Vs62zzqX2I5yQo5Td6JfROvC0yYIiM31KqUeTlBKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XSuJGz6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XSuJGz6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9C81F00893;
	Wed, 23 Sep 2026 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790165292;
	bh=wYJK0qAVqQSmX0wxJ+vjxLsKfN7eDE/pw0TZNKcvAMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XSuJGz6QSIMFbgbSk8AzeZk/GLcK1Lpeofju0iONrBxJQLCQldjoPVYIPezjlLFuc
	 JAvfMbn2upyr2+k8oIb6iwZVSGrscC2sdNvnesnjRbgtlasKi3AkEGtFvg/QimK/Oo
	 7umOOy2j732mh1RKgNs6jPti2pVU98mK96d/PFdw=
Date: Wed, 23 Sep 2026 14:08:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: jaidevshastri@vt.edu
Cc: Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: xilinx_uartps: publish console_port with release
 semantics
Message-ID: <2026092331-pope-avalanche-40ce@gregkh>
References: <20260921-mb-uartps-v1-1-9fc2f3d4b1a5@vt.edu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-mb-uartps-v1-1-9fc2f3d4b1a5@vt.edu>

On Mon, Sep 21, 2026 at 09:21:13PM -0400, Jaidev Shastri via B4 Relay wrote:
> From: Jaidev Shastri <jaidevshastri@vt.edu>
> 
> cdns_uart_probe() assigns the first probed port to console_port with a
> plain store once the port is set up. cdns_uart_console_write() and
> cdns_uart_console_setup() read it with plain loads.
> 
> Store it with smp_store_release() and read it with smp_load_acquire().
> 
> Found with MBCheck, a static herd7-based memory consistency checker.

And how was this tested?  The shashiko review bot shows where your tool
looks wrong...

