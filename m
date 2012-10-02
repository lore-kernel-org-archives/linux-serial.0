From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v2] serial/arc-uart: Add new driver
Date: Tue, 2 Oct 2012 12:47:07 +0100
Message-ID: <20121002124707.32b70292@bob.linux.org.uk>
References: <1349154216-7906-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349154216-7906-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet.Gupta1@synopsys.com
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> +/* Is this for UART emulation on ARC Instruction Set Simulator (ISS)
> */ +int __attribute__((weak)) running_on_iss;

Why not pass a quirks field in your platform data instead - much
cleaner than a global.
> +static void arc_serial_set_ldisc(struct uart_port *port, int ld)
> +{
> +}

If you don't need it just remove this one

> +	new->c_cflag &= ~(CMSPAR|CRTSCTS);

also force the CSIZE bits to CS8 if you only do 8N1.

Alan
