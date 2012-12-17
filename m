From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: tegra: add serial driver
Date: Mon, 17 Dec 2012 18:23:43 +0000
Message-ID: <20121217182343.37324522@pyramind.ukuu.org.uk>
References: <1355746249-15347-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1355746249-15347-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, swarren@wwwdotorg.org
List-Id: linux-serial@vger.kernel.org



> +
> +static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup, i=
nt count)
> +{
> +	int copied;
> +
> +	tup->uport.icount.rx +=3D count;
> +	dma_sync_single_for_cpu(tup->uport.dev, tup->rx_dma_buf_phys,
> +				TEGRA_UART_RX_DMA_BUFFER_SIZE, DMA_FROM_DEVICE);
> +	copied =3D tty_insert_flip_string(tup->uport.state->port.tty,

Reference needed and port.tty can go to NULL
(good rule of thumb - any use of port.tty directly is probably wrong)

=E2=80=8E
> +	tty_flip_buffer_push(u->state->port.tty);

Ditto (and elsewhere)

> +	if ((c_cflag & PARENB) =3D=3D PARENB) {
> +		symb_bit++;
> +		if ((c_cflag & CMSPAR) =3D=3D CMSPAR) {
> +			dev_err(tup->uport.dev, "Space parity not supported\n");
> +			return;

No - this is out of spec and lets user tasks spam the log. Just clear t=
he
flag if not supported.


> +	/* Baud rate. */
> +	baud =3D uart_get_baud_rate(u, termios, oldtermios, 200, 4000000);
> +	spin_unlock_irqrestore(&u->lock, flags);
> +	tegra_set_baudrate(tup, baud);
> +	spin_lock_irqsave(&u->lock, flags);

I think you need to use the helpers to put the actual baud it got into =
the
termios if not B0 - see 8250.c ?

Alan
