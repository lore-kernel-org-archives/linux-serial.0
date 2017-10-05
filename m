From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] serial: sh-sci: Use of_device_get_match_data() helper
Date: Thu, 5 Oct 2017 11:17:53 +0200
Message-ID: <20171005091752.GP26369@verge.net.au>
References: <1507119716-12958-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507119716-12958-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 04, 2017 at 02:21:56PM +0200, Geert Uytterhoeven wrote:
> Use the of_device_get_match_data() helper instead of open coding.
> Note that when used with DT, there's always a valid match.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
