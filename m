From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 3/3] ARM: dts: STi: Remove "console=ttyASN" from
 bootargs for STi boards
Date: Wed, 14 Mar 2018 14:57:01 +0100
Message-ID: <20180314135701.GA20286@kroah.com>
References: <1520444134-30144-1-git-send-email-patrice.chotard@st.com>
 <1520444134-30144-4-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520444134-30144-4-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patrice.chotard@st.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 07, 2018 at 06:35:34PM +0100, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> As serial interface is already specified into stdout-path property,
> "console=ttyASN,115200" from bootargs can be removed.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
> v4: _ none
> v3: _ remove "console=serialN,115200" from bootargs and use prefered 
>       stdout-path property
> v2: _ none
> 

This patch does not apply at all, are you sure you made it correctly?

Can you please fix it up and resend?

thanks,

greg k-h
