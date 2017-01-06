From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 18/19] serial: sh-sci: Remove unused platform data capabilities field
Date: Fri, 06 Jan 2017 13:05:50 +0200
Message-ID: <1843445.xM9acOKP5n@avalon>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-19-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdWwcj16L6_bdBODo8RtM9PtBO0L5S_yjnKs-jQww3TYqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWwcj16L6_bdBODo8RtM9PtBO0L5S_yjnKs-jQww3TYqg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On Friday 06 Jan 2017 11:59:58 Geert Uytterhoeven wrote:
> On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart wrote:
> > The field isn't set by any platform but is only used internally in the
> > driver to hold data parsed from DT. Move it to the sci_port structure.
> 
> This does mean legacy platform data can no longer set it
> (no platform data did).

Correct. Platforms that want to set it should migrate to DT :-)

> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

-- 
Regards,

Laurent Pinchart
