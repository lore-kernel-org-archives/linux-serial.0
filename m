From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: RE: [PATCH v5] devicetree: bindings: uart: Add new compatible
 string for ZynqMP
Date: Wed, 5 Oct 2016 12:23:15 +0000
Message-ID: <C89496FEAE474D468F30D558A9468D9F26D2AB89@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1474898801-36571-1-git-send-email-navam@xilinx.com>
 <20161003184234.GA13165@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161003184234.GA13165@rob-hp-laptop>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Soren Brinkmann <sorenb@xilinx.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.com" <jslaby@suse.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

	Thanks for the review...

> > Changes for v5:
> > 		-Fixed some minor comments.
> 
> Not a useful changelog. The point of these comments is to remind the
> reviewers of what they commented on.

Ok will take care from next version onwards...

> >  Required properties:
> > -- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
> > +- compatible :
> > +  Use "cdns,uart-r1p8", or "xlnx,xuartps" for Zynq-7xxx SoC.
> 
> This is still not right. It was wrong before, but you are touching it so make it
> right.
> 
> OR doesn't match the dts files. It is AND and the opposite order.
> 
> xlnx,xuartps wasn't the best naming, but it's in use so we'll have to live with it
> for zynq-7xxx.
> 
> > +  Use "cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.
> 
> What I meant here was this should have something like "xlnx,mpsoc-uart"
> as the first compatible with "cdns,uart-r1p12" as the second. Not sure if
> "mpsoc" is the best name here.

You mean something like below
 Use "xlnx,xuartps" or "cdns,uart-r1p8" for Zynq-7xxx SoC.
Use "xlnx,zynqmp-uart" or " cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.

Please correct me if my understanding is wrong.

Regards,
Navakishore.
