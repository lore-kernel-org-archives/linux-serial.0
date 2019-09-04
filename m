From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/7] serial: fsl_linflexuart: Be consistent with the
 name
Date: Wed, 4 Sep 2019 09:52:59 +0200
Message-ID: <20190904075259.GA10983@kroah.com>
References: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
 <20190823191115.18490-5-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823191115.18490-5-stefan-gabriel.mirea@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 23, 2019 at 07:11:37PM +0000, Stefan-gabriel Mirea wrote:
> For consistency reasons, spell the controller name as "LINFlexD" in
> comments and documentation.
> 
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  drivers/tty/serial/Kconfig                      | 8 ++++----
>  drivers/tty/serial/fsl_linflexuart.c            | 4 ++--
>  include/uapi/linux/serial_core.h                | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)

Doesn't apply to my tty-next tree :(
