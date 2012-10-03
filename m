From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v3] serial/8250/8250_early: Prevent rounding error in
 uartclk
Date: Wed, 3 Oct 2012 13:37:40 +0100
Message-ID: <20121003133740.69c9dbce@bob.linux.org.uk>
References: <1349267263-21683-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349267263-21683-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Vineet.Gupta1@synopsys.com
List-Id: linux-serial@vger.kernel.org

> So the bug had been latent and it only showed up with such low cock
> rates.

clock ?

Perhaps Greg can tweak the description as it goes in - otherwise all
fine with me
