From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 05/11] serial: sh-sci: Do not open-code sci_getreg()
Date: Fri, 29 Apr 2016 08:39:38 -0700
Message-ID: <5723803A.8090508@hurleysoftware.com>
References: <1461934714-18681-1-git-send-email-geert+renesas@glider.be>
 <1461934714-18681-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461934714-18681-6-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04/29/2016 05:58 AM, Geert Uytterhoeven wrote:
> Replace open-coded variants of sci_getreg() by function calls, and drop
> intermediate variables where appropriate.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
