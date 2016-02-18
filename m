From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 04/12] ata: ahci_mvebu: add support for Armada 3700
 variant
Date: Thu, 18 Feb 2016 12:41:56 -0500
Message-ID: <20160218174156.GF13177@mtj.duckdns.org>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
 <1455646502-23834-5-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455646502-23834-5-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 16, 2016 at 07:14:54PM +0100, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> The main difference in the new Armada 3700 is that no address
> decoding needs to take place in the driver probe.
> 
> [gregory.clement@free-electrons.com: reformulate the commit log]
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> Tested-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to libata/for-4.6.

Thanks.

-- 
tejun
