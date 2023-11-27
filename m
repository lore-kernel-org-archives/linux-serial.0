Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21133D5A;
	Mon, 27 Nov 2023 11:23:20 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 32EDF206D2;
	Mon, 27 Nov 2023 20:23:18 +0100 (CET)
Date: Mon, 27 Nov 2023 20:23:14 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Sean Wang <sean.wang@mediatek.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Bluetooth: fix recv_buf() return value
Message-ID: <ZWTsoot/kAprNFz0@francesco-nb.int.toradex.com>
References: <20231127191409.151254-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127191409.151254-1-francesco@dolcini.it>

Hello Jiri,

On Mon, Nov 27, 2023 at 08:14:05PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Serdev recv_buf() callback is supposed to return the amount of bytes
> consumed, therefore an int in between 0 and count.

I have also a patch ready to convert the return value of serdev
recv_buf() from int to size_t.

I would be inclined to wait for this series to go though first, given
that these are fixes, while the change from int to size_t is just a
cleanup to prevent future mistakes. Do you agree of would you do it
differently?

Francesco

