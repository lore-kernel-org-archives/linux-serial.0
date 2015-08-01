From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: etraxfs-uart: remove empty functions
Date: Sat, 1 Aug 2015 08:00:59 -0700
Message-ID: <20150801150059.GA2553@roeck-us.net>
References: <1437782440-11414-1-git-send-email-nks@flawful.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437782440-11414-1-git-send-email-nks@flawful.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <nks@flawful.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Jul 25, 2015 at 02:00:40AM +0200, Niklas Cassel wrote:
> Implementing enable_ms is optional by serial_core.
> check_modem_status is just an empty local function.
> 
> Signed-off-by: Niklas Cassel <nks@flawful.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
