From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
	device probe
Date: Mon, 20 Jan 2014 10:05:30 +0000
Message-ID: <20140120100530.GY15937@n2100.arm.linux.org.uk>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org> <1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, jslaby@suse.cz, gregkh@linuxfoundation.org, ben.dooks@codethink.co.uk, broonie@kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 20, 2014 at 02:32:34PM +0530, Tushar Behera wrote:
> uart_register_driver call binds the driver to a specific device
> node through tty_register_driver call. This should typically happen
> during device probe call.
> 
> In a multiplatform scenario, it is possible that multiple serial
> drivers are part of the kernel. Currently the driver registration fails
> if multiple serial drivers with same default major/minor numbers are
> included in the kernel.
> 
> A typical case is observed with amba-pl011 and samsung-uart drivers.

The samsung-uart driver is at fault here - the major/minor numbers were
officially registered to amba-pl011.  Samsung needs to be fixed properly.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
