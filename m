From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC] arm64: dts: r8a7796-salvator-x: Disable sdr104 of
 SDHI
Date: Mon, 7 Nov 2016 16:41:38 +0100
Message-ID: <20161107154137.GC9233@verge.net.au>
References: <1478532814-8652-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478532814-8652-1-git-send-email-horms@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 07, 2016 at 04:33:34PM +0100, Simon Horman wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> 
> The problem which the card inserted in the slot of SDHI{0,3} does not
> recognize in the combination of some boards and UHS-I sdcard occurred.
> 
> Therefore, this patch repealed SDR104 of SDHI0 and SDHI3.

Sorry, I withdraw this patch; it is not relevant to mainline.
I meant to send a completely different patch.
