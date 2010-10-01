From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 6/8] altera_uart: Fixup type usage of port flags
Date: Fri, 1 Oct 2010 15:54:34 +0200
Message-ID: <20101001135434.GB10579@distanz.ch>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru> <20101001132237.GF25897@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101001132237.GF25897@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2010-10-01 at 15:22:37 +0200, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> port->flags is of type upf_t, which corresponds to UPF_* flags.
> 
> ASYNC_BOOT_AUTOCONF is an unsigned integer, which happen to
> be the same as UPF_BOOT_AUTOCONF.
> 
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

Acked-by: Tobias Klauser <tklauser@distanz.ch>
