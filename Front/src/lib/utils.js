export async function POST(route, donnes, url = 'http://127.0.0.1:4002') {
    const res = await fetch(url + route || '', {
        method: 'POST',
        body: JSON.stringify(donnes),
        headers: {
            'Content-type': 'application/json; charset=UTF-8',
        }
    })

    if (res.ok) {
        return await res.json();
    } else {
        // Sometimes the API will fail!
        throw new Error('Request failed');
    }
}

export async function GET(url, base = "http://127.0.0.1:4002") {
    const res = await fetch(base + url)
        .then(e => e.json())
        .then((e) => e)
    return res;
}