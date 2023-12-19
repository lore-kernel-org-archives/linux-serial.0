Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865E182DD;
	Tue, 19 Dec 2023 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4SvYrH6w9Rzvjfn; Tue, 19 Dec 2023 12:10:07 +0100 (CET)
Date: Tue, 19 Dec 2023 12:10:07 +0100
From: Tobias Klauser <tklauser@distanz.ch>
To: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/serial: altera_uart: use more informative labels in
 /proc/interrupts
Message-ID: <20231219111007.pqvo54lwzauhpzws@distanz.ch>
References: <20231217195601.236002-1-antonynpavlov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217195601.236002-1-antonynpavlov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On 2023-12-17 at 20:56:01 +0100, Antony Pavlov <antonynpavlov@gmail.com> wrote:
> Prior to this patch:
> 
> ~# cat /proc/interrupts
> ...
>  40:        123          0     GIC-0  72 Level     altera_uart
>  41:          9          0     GIC-0  73 Level     altera_uart
> 
> After this patch:
> 
> ~# cat /proc/interrupts
> ...
>  40:          6          0     GIC-0  72 Level     ff200100.fpga-uart0
>  41:         28          0     GIC-0  73 Level     ff200200.fpga-uart1
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks!
