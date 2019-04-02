From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 1/2] tty: add SPDX identifiers to Kconfig and Makefiles
Date: Tue, 2 Apr 2019 16:20:16 +0200
Message-ID: <20190402142016.GB29086@suse.cz>
References: <20190402140708.519-1-gregkh@linuxfoundation.org>
Reply-To: dsterba@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190402140708.519-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>, Jiri Slaby <JSlaby@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 02, 2019 at 04:07:07PM +0200, Greg Kroah-Hartman wrote:
> There were a few Kconfig and Makefiles under drivers/tty/ that were
> missing a SPDX identifier.  Fix that up so that automated tools can
> properly classify all kernel source files.
> 
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

For

>  drivers/tty/ipwireless/Makefile      | 1 +

Acked-by: David Sterba <dsterba@suse.com>
