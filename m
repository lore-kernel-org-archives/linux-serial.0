From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 4/8] altera_uart: Add support for different address
	strides
Date: Fri, 1 Oct 2010 16:01:07 +0200
Message-ID: <20101001140107.GD10579@distanz.ch>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru> <20101001132154.GD25897@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101001132154.GD25897@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2010-10-01 at 15:21:54 +0200, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> Some controllers implement registers with a stride, to support
> those we must implement the proper IO accessors.
> 
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks.
