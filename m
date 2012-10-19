From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH tty-next] x86: ce4100: allow second UART usage
Date: Fri, 19 Oct 2012 10:56:36 +0100
Message-ID: <20121019105636.56e89a5a@pyramind.ukuu.org.uk>
References: <1350636307-23476-1-git-send-email-ffainelli@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350636307-23476-1-git-send-email-ffainelli@freebox.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <ffainelli@freebox.fr>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, mbizon@freebox.fr
List-Id: linux-serial@vger.kernel.org

On Fri, 19 Oct 2012 10:45:07 +0200
Florian Fainelli <ffainelli@freebox.fr> wrote:

> From: Maxime Bizon <mbizon@freebox.fr>
> 
> The current CE4100 and 8250_pci code have both a limitation preventing the
> registration and usage of CE4100's second UART. This patch changes the
> platform code fixing up the UART port to work on a relative UART port
> base address, as well as the 8250_pci code to make it register 2 UART ports
> for CE4100 and pass the port index down to all consumers.
> 
> Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>

Acked-by: Alan Cox <alan@linux.intel.com>
