From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 1/2] serial: Add driver for the Altera JTAG UART
Date: Fri, 26 Feb 2010 10:06:04 +0100
Message-ID: <20100226090604.GB32296@distanz.ch>
References: <1267108523-32767-1-git-send-email-tklauser@distanz.ch> <87ocjd5knm.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87ocjd5knm.fsf@macbook.be.48ers.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2010-02-25 at 17:45:33 +0100, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Tobias" == Tobias Klauser <tklauser@distanz.ch> writes:
> 
>  Tobias> Add an UART driver for the JTAG UART component available as a SOPC
>  Tobias> (System on Programmable Chip) component for Altera FPGAs.
> 
>  Tobias> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
>  
>  Tobias> +config SERIAL_ALTERA_JTAGUART
>  Tobias> +	bool "Altera JTAG UART support"
>  Tobias> +	depends on EMBEDDED
> 
> Don't depend on EMBEDDED - There's embedded devices not using
> CONFIG_EMBEDDED and kernel configs for PCs using it.

I'll remove the dependency for bot altera_jtaguart and altera_uart.

Thanks a lot,
Tobias
