From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] tty: serial: msm_serial: Use DT aliases
Date: Fri, 07 Nov 2014 10:47:05 +0100
Message-ID: <2747100.M77UGx4AmB@wuerfel>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org> <545C694D.1030204@gmail.com> <545C69E7.6010909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <545C69E7.6010909@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, frowand.list@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thursday 06 November 2014 22:42:47 Frank Rowand wrote:
> This same change is also needed in:
> 
>   qcom-ipq8064.dtsi
>   qcom-msm8960.dtsi
>   qcom-apq8084.dtsi
>   qcom-apq8064.dtsi
>   qcom-msm8660.dtsi
> 
> but I did not want to just blindly apply those changes without testing.
> 

Is there only one uart on each of these?

If not, it would be better to put the aliases in the board specific file,
pointing to whichever ports are in use, in the order that makes sense
for that board.

	Arnd
